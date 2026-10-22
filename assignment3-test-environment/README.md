# Assignment 3 测试环境

这套项目用于 Section 5 的环境搭建，并为后续 Section 6 自动化测试提供公共框架。技术栈为 Python 3.14、Selenium、pytest、pytest-html 和 Chrome for Testing。软件包版本记录在 `requirements.txt`，浏览器版本记录在 `browser-version.txt`。

## Mac 上直接运行

在此文件夹打开终端，运行：

```bash
./run-tests.command -v
```

想看到浏览器窗口：

```bash
./run-tests.command -v --headed
```

重新安装依赖或在另一台 Mac 配置时，先安装 Python 3.14（本机实测 3.14.4），然后运行：

```bash
./setup-macos.command
```

也可直接调用 `.venv/bin/python -m pytest -v`，无需激活虚拟环境。移动或重命名项目后应重新创建 `.venv`，不要复制旧虚拟环境到另一台电脑。

## Windows 组员安装

1. 安装官方 Python 3.14，建议统一使用 3.14.4。安装来源：<https://www.python.org/downloads/>。确认 `py -3.14 --version` 可用。
2. 解压共享 ZIP 到普通工作文件夹，或从你们以后建立的 GitHub 仓库获取项目。
3. 在项目目录的 CMD 或 PowerShell 运行 `./setup-windows.cmd`。脚本创建自己的 `.venv`、安装锁定依赖，并运行环境验证测试。无需修改 PowerShell 执行策略。
4. 以后运行 `./run-tests.cmd -v`；显示浏览器则运行 `./run-tests.cmd -v --headed`。
5. 把各自生成的 `reports/environment.json` 和测试结果交给报告负责人；按成员分别记录 Windows 版本、架构、Python、浏览器及编辑器版本。

Windows 脚本已提供，但本项目的 Windows 实机结果必须由对应组员运行后填写。不能把 Mac 的通过结果当成 Windows 已验证。

## 浏览器与驱动

首次测试由 Selenium Manager 下载固定版本的 Chrome for Testing 和匹配的 ChromeDriver，保存在项目 `.cache/selenium/`。这是独立测试浏览器，不使用日常 Chrome 的登录状态和历史记录。每个测试自动创建新会话，并在测试后退出浏览器。

首次安装和在线测试需要网络。后续本地浏览器检查可运行：

```bash
./run-tests.command -v -m "smoke and not online"
```

Windows 将上述启动器换成 `./run-tests.cmd`。离线检查首次也必须先完成浏览器和驱动下载。

## 结果与截图

- `reports/report.html`：可单独打开的 HTML 测试报告，包含浏览器截图。
- `reports/results.xml`：JUnit 格式结果。
- `reports/environment.json`：运行时采集的真实版本与平台信息。
- `reports/screenshots/`：每个已进入测试执行阶段的浏览器截图；若浏览器启动失败则不会有截图。

再次运行会覆盖同名结果。正式作业测试后，请及时复制证据到按成员和测试编号命名的文件夹。

当前两项 smoke tests 分别验证浏览器输入/点击/断言和作业网站访问。它们用于确认环境，**不等于每人需要提交的三个功能 Test Cases**，也不构成整个网站测试通过的结论。报告要求的源代码截图仍需在完成正式测试代码后分别截取。

## 后续添加功能测试

把测试写在 `tests/test_member1.py` 等文件内。可直接使用公共 `driver`、`wait` 和 `base_url` fixtures：

```python
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC

def test_your_scenario(driver, wait, base_url):
    driver.get(base_url + "?route=account/login")
    field = wait.until(EC.visibility_of_element_located((By.ID, "input-email")))
    assert field.is_enabled()
```

这个例子只展示框架用法，不是完整的登录测试。每个 scenario 应独立准备初始数据，并用断言比较预期与实际结果。公共 fixture 使用显式等待，不依赖固定 `sleep`。

## 编辑器

可以在 Codex 的文件编辑器中打开项目文件并使用终端运行测试。本次未安装或验证 VS Code。若成员使用 VS Code，可安装 Microsoft Python 扩展，打开项目文件夹并选择 `.venv` 解释器；已提供 `.vscode` 的 pytest 配置。使用其他编辑器也可以，Section 5 应写实际使用的编辑器及版本。

## 共享代码

共享 ZIP 不包含 `.venv`、缓存、浏览器、个人配置或运行报告；`evidence/` 中的本机验证存档也仅保留在本机。各成员安装自己的环境。项目已提供 `.gitignore`，可用于后续 GitHub 仓库；本次没有创建仓库或上传文件。GitHub 不是运行测试的必要条件。

## 排错

- 下载失败：检查网络能否访问 PyPI、`googlechromelabs.github.io` 和 `storage.googleapis.com`。保留报错，不要关闭证书检查。
- 网站检查失败而本地检查通过：检查学校网站地址、网络和页面是否发生变化，报告为访问或定位问题，不要直接认定业务功能有缺陷。
- 解释器错误：确认命令使用项目内 `.venv`，而非 Anaconda 或其他全局 Python。
- Chrome/驱动版本错误：检查 `browser-version.txt` 与运行报告；不要硬编码其他成员电脑上的驱动路径。

官方参考：
- Selenium Manager：<https://www.selenium.dev/documentation/selenium_manager/>
- pytest：<https://docs.pytest.org/en/stable/getting-started.html>
- Chrome for Testing：<https://googlechromelabs.github.io/chrome-for-testing/>

AI 使用记录：本环境框架、安装脚本与说明由 Codex 根据用户提供的作业要求、模板和分享对话协助生成。若正式测试继续使用 AI 生成代码或 prompts，请根据模板要求记录实际使用情况。
