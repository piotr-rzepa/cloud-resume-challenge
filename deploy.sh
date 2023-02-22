# No shebang #!bin/bash included, since I'm executing the script on git console

SAM_CLI_PATH=$1

PATH_TO_SAM_TEMPLATE=$2

echo "Building Code defined in SAM Template $PATH_TO_SAM_TEMPLATE"
$SAM_CLI_PATH build -t $PATH_TO_SAM_TEMPLATE

echo "Deploying Code..."
$SAM_CLI_PATH deploy
