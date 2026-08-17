from pathlib import Path
import sys


def fail(message: str) -> None:
    print(message, file=sys.stderr)
    raise SystemExit(1)


root = Path(__file__).resolve().parents[1]
files = [
    path
    for path in root.rglob("*")
    if path.is_file() and path.suffix in {".md", ".yaml"}
]
text = "\n".join(path.read_text(encoding="utf-8") for path in files)

system_name = "知识内容系统"
explicit_calls = [
    system_name,
    f"用{system_name}",
    f"调用{system_name}",
    f"打开{system_name}",
    f"启动{system_name}",
]

skill_yaml = (root / "skill.yaml").read_text(encoding="utf-8")
openai_yaml = (root / "agents" / "openai.yaml").read_text(encoding="utf-8")

if f"name: {system_name}" not in skill_yaml:
    fail("skill.yaml display name is incorrect.")
if f'display_name: "{system_name}"' not in openai_yaml:
    fail("OpenAI display name is incorrect.")

for phrase in explicit_calls:
    if phrase not in text:
        fail(f"Missing explicit invocation: {phrase}")

legacy_english_name = "Professional Method Compiler"
if legacy_english_name in text:
    fail("Unexpected user-visible legacy English name.")

no_write = "不创建长期记忆或工作空间"
legacy_workspace = "旧工作区"
if no_write not in text:
    fail("Default no-write protection missing.")
if legacy_workspace not in text:
    fail("Legacy workspace compatibility missing.")

print("Knowledge Content System rename acceptance checks: PASS")
