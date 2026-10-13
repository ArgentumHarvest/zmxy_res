$ErrorActionPreference = 'Stop'
Push-Location $PSScriptRoot
try {
    $quizData = Join-Path $PSScriptRoot 'questions.json'
    python -m PyInstaller --noconfirm --windowed --onedir --name AnswerPanel --add-data "$quizData;." --collect-data rapidocr_onnxruntime --collect-binaries onnxruntime app.py
    if ($LASTEXITCODE -ne 0) { throw '打包失败，请检查输出信息。' }
} finally {
    Pop-Location
}
