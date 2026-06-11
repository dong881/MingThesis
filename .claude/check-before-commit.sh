#!/bin/bash

# ========================================================================
# Pre-Commit Check Script for MingThesis
# ========================================================================
# 在提交 git 变更前运行此脚本，确保：
# 1. 术语一致性 ✓
# 2. LaTeX 编译无错误 ✓
# 3. 所有图表都被引用 ✓
# ========================================================================

set -e  # 任何错误都停止执行

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}MingThesis Pre-Commit Check${NC}"
echo -e "${BLUE}========================================${NC}\n"

ERRORS=0

# ========================================================================
# 1. 术语一致性检查 (强制性!)
# ========================================================================
echo -e "${YELLOW}[1/4] Checking Terminology Consistency...${NC}"

DISALLOWED_TERMS=(
    "slots-ahead"      # Should be: slots ahead
    "slotsahead"       # Should be: slots ahead
    "slot-ahead"       # Should be: slots ahead
    "timing-info"      # Should be: Timing Info / timing info
    "Timing-info"      # Should be: Timing Info
    "delay-management" # Should be: delay management
    "node-sync"        # Should be: node sync
    "Node-sync"        # Should be: node sync
)

TERM_ERRORS=0
for term in "${DISALLOWED_TERMS[@]}"; do
    # 搜索所有 .tex 和 .md 文件
    if grep -rn "$term" NTUST/sections/ 2>/dev/null | grep -v ".git"; then
        echo -e "${RED}  ✗ Found disallowed term: '$term'${NC}"
        TERM_ERRORS=$((TERM_ERRORS + 1))
    fi
done

if [ $TERM_ERRORS -eq 0 ]; then
    echo -e "${GREEN}  ✓ Terminology check passed${NC}\n"
else
    echo -e "${RED}  ✗ Found $TERM_ERRORS terminology issues${NC}"
    echo -e "${YELLOW}  Please fix using: .claude/skills/standards/terminology-consistency.md${NC}\n"
    ERRORS=$((ERRORS + 1))
fi

# ========================================================================
# 2. LaTeX 编译检查
# ========================================================================
echo -e "${YELLOW}[2/4] Checking LaTeX Compilation...${NC}"

if command -v latexmk &> /dev/null; then
    if latexmk -interaction=nonstopmode main.tex > /tmp/latexmk.log 2>&1; then
        echo -e "${GREEN}  ✓ LaTeX compilation successful${NC}"

        # 检查是否有未解析的引用
        if grep -q "Undefined control sequence\|There were undefined references" /tmp/latexmk.log; then
            echo -e "${RED}  ✗ Warning: There may be unresolved references${NC}"
            echo -e "${YELLOW}    Check build/main.pdf for [?] symbols${NC}\n"
        else
            echo -e "${GREEN}  ✓ No obvious unresolved references${NC}\n"
        fi
    else
        echo -e "${RED}  ✗ LaTeX compilation failed${NC}"
        echo -e "${YELLOW}  See /tmp/latexmk.log for details${NC}\n"
        ERRORS=$((ERRORS + 1))
    fi
else
    echo -e "${YELLOW}  ⊘ latexmk not installed, skipping compilation check${NC}\n"
fi

# ========================================================================
# 3. 图表引用检查
# ========================================================================
echo -e "${YELLOW}[3/4] Checking Figure References...${NC}"

# 查找所有 \includegraphics 引用
FIGURES=$(grep -rh "\\\\includegraphics" NTUST/sections/*.tex | \
    sed 's/.*includegraphics\(\[.*\]\)\?{\([^}]*\)}.*/\2/g' | \
    sort | uniq)

MISSING_FIGURES=0
for fig in $FIGURES; do
    if [ ! -f "$fig" ]; then
        echo -e "${RED}  ✗ Missing figure file: $fig${NC}"
        MISSING_FIGURES=$((MISSING_FIGURES + 1))
    fi
done

if [ $MISSING_FIGURES -eq 0 ]; then
    echo -e "${GREEN}  ✓ All referenced figures exist${NC}\n"
else
    echo -e "${RED}  ✗ Found $MISSING_FIGURES missing figure(s)${NC}\n"
    ERRORS=$((ERRORS + 1))
fi

# ========================================================================
# 4. Git 状态检查
# ========================================================================
echo -e "${YELLOW}[4/4] Checking Git Status...${NC}"

STAGED=$(git diff --cached --name-only 2>/dev/null || echo "")
if [ -z "$STAGED" ]; then
    echo -e "${YELLOW}  ⊘ No files staged for commit${NC}"
    echo -e "${YELLOW}    Tip: Run 'git add NTUST/sections/ figures/ build/main.pdf references.bib'${NC}\n"
else
    echo -e "${GREEN}  ✓ Files staged:${NC}"
    echo "$STAGED" | sed 's/^/    /'
    echo ""
fi

# ========================================================================
# 总结
# ========================================================================
echo -e "${BLUE}========================================${NC}"

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed! Ready to commit.${NC}"
    echo -e "${GREEN}Run: git commit -m \"your message here\"${NC}"
    echo -e "${BLUE}========================================${NC}\n"
    exit 0
else
    echo -e "${RED}✗ Found $ERRORS error(s). Fix before committing.${NC}"
    echo -e "${BLUE}========================================${NC}\n"
    exit 1
fi
