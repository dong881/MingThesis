# 快速参考卡 (Quick Reference Card)

**打印此页或加入书签** 📌

---

## 🔴 最强制性: 术语检查 ⭐⭐⭐

**在每次 git commit 前运行：**

```bash
# 自动化检查脚本
bash .claude/check-before-commit.sh

# 或手动检查
grep -rn "slots.ahead\|slots-ahead\|slotsahead" NTUST/sections/
grep -rn "timing.info\|timing-info\|Timing-info" NTUST/sections/
grep -rn "delay.management\|delay-management" NTUST/sections/
grep -rn "node.sync\|node-sync\|Node-sync" NTUST/sections/
```

**必须的术语:**
| ✅ 正确 | ❌ 错误 |
|--------|--------|
| slots ahead | slots-ahead, slotsahead |
| Timing Info (标题) / timing info (正文) | timing-info, Timing-info |
| delay management | delay-management |
| node sync | node-sync |

📖 详细信息：`.claude/skills/standards/terminology-consistency.md`

---

## 📝 论文写作指南 (Writing Workflow)

### 新章节的 3 步法

```
1️⃣  准备 (Preparation)
   - 找到你的目标（读者应该知道什么）
   - 列出所有想法
   - 整理想法

2️⃣  书写 (Writing)
   - 支持你的论点（至少 2-3 个例子）
   - 分隔关键要点（每段一个主题）
   - 简短句子（12-15 字以内）

3️⃣  编辑 (Editing)
   - 第一遍：结构 → 短句子 → 删除不必要的
   - 第二遍：标点符号
   - 第三遍：词汇选择 → 简化
   - 第四遍：朗读或给朋友读
```

📖 详细信息：`.claude/skills/writing/paper-thesis-writing-guide.md`

---

## 🛠️ 日常任务快速命令

### 编译论文
```bash
latexmk main.tex
# 输出: build/main.pdf

# 清除编译文件（保留 PDF）
latexmk -c main.tex

# 完全清除
latexmk -C main.tex
```

### 提交代码
```bash
# 1. 运行检查脚本 (必须!)
bash .claude/check-before-commit.sh

# 2. 暂存文件
git add NTUST/sections/ figures/ build/main.pdf references.bib

# 3. 提交
git commit -m "feat(thesis): brief description"
# 或
git commit -m "fix(thesis): brief description"
# 或
git commit -m "docs(thesis): brief description"
```

### 查找并检查 Skills
```bash
# 查看 skills 索引
cat .claude/SKILLS.md

# 查看特定 skill
cat .claude/skills/writing/paper-thesis-writing-guide.md
cat .claude/skills/standards/terminology-consistency.md
cat .claude/skills/writing/vocabulary-level-guide.md

# 查看想法数据库
cat .claude/skills/database/thesis-idea-database.md
ls .claude/skills/database/thesis-idea-database/ideas/
```

---

## 📋 编辑检查清单 (Before Editing Section)

- [ ] 看一遍相关的写作指南
- [ ] 查看想法数据库，确保逻辑一致
- [ ] 参考词汇简化指南避免复杂词汇
- [ ] 提供至少 2-3 个例子支持每个论点

📖 详细信息：`.claude/skills/writing/technical-writing-checklist.md`

---

## ✅ 提交检查清单 (Before git commit)

必须按顺序检查：

1. **术语一致性** ⭐⭐⭐ (强制!)
   ```bash
   bash .claude/check-before-commit.sh
   ```

2. **LaTeX 编译**
   ```bash
   latexmk main.tex
   # 查看: build/main.pdf (应该无 [?] 引用)
   ```

3. **图表完整性**
   - [ ] 所有新增图表都有描述性标题
   - [ ] 所有图表都在正文中被引用
   - [ ] X 轴、Y 轴都有标签和单位

4. **术语一致**
   - [ ] 只使用表中的首选术语
   - [ ] 不使用连字符或混合大小写的变体

5. **提交步骤**
   ```bash
   git add NTUST/sections/ figures/ build/main.pdf references.bib
   git commit -m "feat/fix/docs(thesis): description"
   ```

---

## 🎨 写作风格要求

### English Style (来自指导教授)
- ✅ **初中英文** - Simple, direct sentences
- ✅ **正确性第一** - Correctness > Complexity
- ❌ 不要用复杂词汇

**常见替换：**

| ❌ 避免 | ✅ 使用 |
|--------|--------|
| Prohibitive | Very high, Expensive |
| Proactively | Actively, In advance |
| Mitigate | Reduce, Solve |
| Resilient | Strong, Stable |
| Catastrophic | Huge, Severe |

📖 详细信息：`.claude/skills/writing/vocabulary-level-guide.md`

---

## 🔗 Skills 地图 (找你需要的)

| 我想... | 查看... |
|--------|----------|
| 开始写新章节 | `paper-thesis-writing-guide.md` |
| 了解工作流程 | `academic-paper-workflow.md` |
| 简化英文 | `vocabulary-level-guide.md` |
| 最后审阅 | `technical-writing-checklist.md` |
| 描述算法 | `nfapi-p7-timing-algorithm.md` |
| 检查术语 | `terminology-consistency.md` 🔴 |
| 提交代码 | `git-auto-commit.md` |
| 查找想法 | `thesis-idea-database/` |

---

## 💻 文件路径速查

```
主文件:
  main.tex                              - IEEE 论文主文件
  NTUST/my_ntust_thesis.tex             - NTUST 学位论文

章节文件:
  NTUST/sections/introduction.tex       - 引言和相关工作
  NTUST/sections/system.tex             - 系统模型
  NTUST/sections/method.tex             - 提议方法
  NTUST/sections/experiment.tex         - 实验和结果
  NTUST/sections/conclusion.tex         - 结论

其他:
  references.bib                        - 参考文献数据库
  figures/                              - 图表和图片
  build/main.pdf                        - 编译输出 (git 追踪)
  .claude/                              - Claude Code 配置和 skills
  CLAUDE.md                             - 项目级指导
```

---

## ⚡ 最常用的 3 个 Commands

```bash
# 1. 预提交检查 (MUST RUN BEFORE COMMIT!)
bash .claude/check-before-commit.sh

# 2. 编译论文
latexmk main.tex

# 3. 提交代码
git add NTUST/sections/ figures/ build/main.pdf references.bib && \
git commit -m "feat/fix(thesis): description"
```

---

## 🎯 提交消息格式

```
feat(thesis): add new experimental scenario
fix(thesis): correct figure label for Scenario IV
docs(thesis): clarify nFAPI timing constraints
```

**前缀说明：**
- `feat:` 新特性、新实验
- `fix:` 修复错误、词汇
- `docs:` 内容更新、澄清

---

## 📞 需要帮助?

1. **查看 SKILLS.md**
   ```bash
   cat .claude/SKILLS.md
   ```

2. **查看特定 skill 文件**
   ```bash
   cat .claude/skills/[category]/[skill-name].md
   ```

3. **运行预检查脚本**
   ```bash
   bash .claude/check-before-commit.sh
   ```

4. **查看 CLAUDE.md** (项目架构)
   ```bash
   cat CLAUDE.md
   ```

---

## 🏁 完成提交的完整流程

```bash
# 1. 编辑文件
#    vim NTUST/sections/introduction.tex

# 2. 编译检查
latexmk main.tex

# 3. 术语检查 (强制!)
bash .claude/check-before-commit.sh

# 4. 如果全部通过，提交
git add NTUST/sections/ figures/ build/main.pdf references.bib
git commit -m "feat(thesis): add introduction to timing control"

# 5. 完成! 🎉
```

---

**保存此快速参考卡** 📌

打印或加入书签以便随时查看!
