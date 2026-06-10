# Claude Code Configuration for MingThesis Project

本目录包含为 Claude Code 优化的项目配置和技能文件。

---

## 📂 目录结构

```
.claude/
├── README.md                              (this file)
├── SKILLS.md                              (skills index & quick reference)
├── settings.json                          (future Claude Code settings)
└── skills/
    ├── writing/                           (论文写作指南)
    ├── technical/                         (技术参考)
    ├── standards/                         (标准和规范)
    ├── database/                          (知识库)
    └── automation/                        (自动化工具)
```

---

## 🚀 Quick Start

### 第一次使用

1. **查看 Skills 索引**：
   ```bash
   cat .claude/SKILLS.md
   ```

2. **最重要的 3 个 Skills** (优先学习):
   - `.claude/skills/standards/terminology-consistency.md` ⭐ 强制性
   - `.claude/skills/writing/paper-thesis-writing-guide.md` 
   - `.claude/skills/writing/academic-paper-workflow.md`

3. **配置 Claude Code**:
   ```bash
   # 如果需要自定义设置，编辑 settings.json
   # (目前为空，可留作未来扩展)
   ```

### 日常工作流程

```bash
# 1. 查看论文写作指南
cat .claude/skills/writing/paper-thesis-writing-guide.md

# 2. 编辑论文章节
# ... 编辑 NTUST/sections/*.tex ...

# 3. 检查术语一致性 (必须!)
grep -rn "slots.ahead\|timing.info\|delay.management" NTUST/sections/

# 4. 编译论文
latexmk main.tex

# 5. 提交变更
git add NTUST/sections/ figures/ build/main.pdf
git commit -m "feat(thesis): update section X"
```

---

## 📚 Skills 按用途分类

### 🖊️ Writing Skills (论文写作)
- `paper-thesis-writing-guide.md` - 完整的论文写作框架
- `academic-paper-workflow.md` - 系统化的工作流程
- `vocabulary-level-guide.md` - 简洁英文风格指南
- `technical-writing-checklist.md` - 每章节检查清单

**何时使用：** 任何写作或编辑工作前

---

### 🔬 Technical Skills (技术参考)
- `nfapi-p7-timing-algorithm.md` - 算法和代码细节
- `advisor-paper-guidelines.md` - 指导教授的要求
- `content-research-writer.md` - 研究内容组织

**何时使用：** 描述技术内容、算法、实验设计

---

### ✅ Standards Skills (标准和规范)
- `terminology-consistency.md` - **强制性** 术语检查表
- `ieee-paper-template.md` - 论文格式规范

**何时使用：** 每次提交前必须检查术语

---

### 💾 Database Skills (知识库)
- `thesis-idea-database/` - 核心论文想法库
- `dual-paper-writing-starter.md` - 双论文维护策略

**何时使用：** 写作前查阅相关想法，确保逻辑一致

---

### ⚙️ Automation Skills (工具)
- `git-auto-commit.md` - 版本控制和自动提交

**何时使用：** 准备提交 LaTeX 变更

---

## 🔗 How to Use Skills in Claude Code

### 方法 1: 直接查看文件

```bash
cat .claude/skills/writing/paper-thesis-writing-guide.md
```

### 方法 2: 在对话中引用

当 Claude Code 询问论文写作时，可以说：
> "请参考 `.claude/skills/writing/paper-thesis-writing-guide.md` 中的建议"

### 方法 3: 自动参考 (推荐)

如果你的项目支持，Claude Code 可以自动在工作时参考这些 skills。目前可以：
1. 在 `.claude/settings.json` 中配置自动引用
2. 或在内存系统中记录常用 skills 的路径

---

## ✨ Key Features

### 1. **术语一致性强制检查** ⭐
在每次提交前，必须检查这些术语：

```bash
# 命令
grep -rn "slots.ahead\|timing.info\|delay.management\|node.sync" NTUST/sections/

# 正确用法 (来自 terminology-consistency.md)
✓ slots ahead           (不要: slots-ahead, slotsahead)
✓ Timing Info           (不要: timing-info, timing info)
✓ delay management      (不要: delay-management)
✓ node sync             (不要: node-sync)
```

### 2. **完整的论文写作框架**
从规划 → 初稿 → 第二稿 → 最终稿，包含每个阶段的检查清单。

### 3. **多论文支持**
维护 IEEE 论文和 NTUST 学位论文两个版本，使用内容重用策略。

### 4. **想法数据库**
追踪核心研究想法，确保论文逻辑连贯。

---

## 📋 Maintenance

### 添加新的 Skill

1. 创建新文件：`.claude/skills/[category]/[skill-name].md`
2. 在 `SKILLS.md` 中添加条目
3. 更新 README 的分类列表

### 更新现有 Skill

- 编辑对应的 `.md` 文件
- 在 `SKILLS.md` 中更新描述（如需要）
- Git commit 以版本化

### 同步到原始位置 (可选)

如果仍需保持 `.agent/skills/` 的同步：
```bash
cd /home/hpe/MingThesis
cp -r .claude/skills/* .agent/skills/
```

---

## 🎯 Best Practices

### 1. **每次写作前**
- ✓ 查看相关的 Writing Skill
- ✓ 查看 thesis-idea-database 确保想法一致

### 2. **每次编辑前**
- ✓ 参考 vocabulary-level-guide 简化英文
- ✓ 查看 technical-writing-checklist 检查结构

### 3. **每次提交前** (强制!)
- ✓ 检查术语一致性 (terminology-consistency.md)
- ✓ 编译论文 (latexmk main.tex)
- ✓ 查看 git-auto-commit.md 的提交步骤

---

## 💡 Tips

- **Skill 文件是活文档** - 在项目进行中可以补充和完善
- **与论文版本化** - Skills 变更与论文提交一起记录
- **支持中英文** - Skills 混合使用中英文（按原创格式保留）

---

## 🔄 Integration with CLAUDE.md

本 `.claude/` 目录与项目根目录的 `CLAUDE.md` 互补：

- **CLAUDE.md** - 项目级别的高级指导和架构信息
- **.claude/SKILLS.md** - 具体的写作和技术 skills
- **.claude/skills/** - 详细的 skill 文档

---

## 📞 Support

如有问题或需要添加新 skill：

1. 查看 `SKILLS.md` 的索引
2. 找相关的 skill 文件
3. 或在 Claude Code 对话中直接引用：
   ```
   "请查看 .claude/skills/[category]/[skill-name].md"
   ```

---

## ✅ Checklist: First Time Setup

- [ ] 阅读 `SKILLS.md`
- [ ] 查看 `.claude/skills/standards/terminology-consistency.md`
- [ ] 查看 `.claude/skills/writing/paper-thesis-writing-guide.md`
- [ ] 理解论文目录结构（见 CLAUDE.md）
- [ ] 准备开始写作或编辑！

