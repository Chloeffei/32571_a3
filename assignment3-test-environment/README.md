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

## Windows

1. 安装官方 Python 3.14，建议统一使用 3.14.4。安装来源：<https://www.python.org/downloads/>。确认 `py -3.14 --version` 可用。
2. 解压共享 ZIP 到普通工作文件夹，或从你们以后建立的 GitHub 仓库获取项目。
3. 在项目目录的 CMD 或 PowerShell 运行 `./setup-windows.cmd`。脚本创建自己的 `.venv`、安装锁定依赖，并运行环境验证测试。无需修改 PowerShell 执行策略。
4. 以后运行 `./run-tests.cmd -v`；显示浏览器则运行 `./run-tests.cmd -v --headed`。
5. 把各自生成的 `reports/environment.json` 和测试结果交给报告负责人；按成员分别记录 Windows 版本、架构、Python、浏览器及编辑器版本。


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
