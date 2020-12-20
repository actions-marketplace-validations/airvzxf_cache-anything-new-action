#!/bin/bash -e

echo "# ----------------------------------------------------------"
echo "# Init the process"
echo "# ----------------------------------------------------------"
echo "ENV_IDENTIFIER:     ${ENV_IDENTIFIER}"
echo "ENV_VERSION:        ${ENV_VERSION}"
echo "ENV_CACHE:          ${ENV_CACHE}"
echo "ENV_SCRIPT:         ${ENV_SCRIPT}"
echo "ENV_SNAPSHOT:       ${ENV_SNAPSHOT}"
echo "ENV_EXCLUDE:        ${ENV_EXCLUDE}"
echo "ENV_RUNNER_TEMP:    ${ENV_RUNNER_TEMP}"
echo "GITHUB_ACTION_PATH: ${GITHUB_ACTION_PATH}"

echo "----------------------------------------"
echo "Directory GITHUB_ACTION_PATH: ${GITHUB_ACTION_PATH}"
echo "----------------------------------------"
ls -lha "${GITHUB_ACTION_PATH}"

echo "----------------------------------------"
echo "Directory ENV_SCRIPT_BASE: ${ENV_SCRIPT_BASE}"
echo "----------------------------------------"
ls -lha "${ENV_SCRIPT_BASE}"

#"${GITHUB_ACTION_PATH}"/snapshot.sh system_files_snapshot_01.txt

echo "# ----------------------------------------------------------"
echo "# Init the user script"
echo "# ----------------------------------------------------------"
#"${ENV_SCRIPT}"

#"${GITHUB_ACTION_PATH}"/snapshot.sh system_files_snapshot_02.txt

#"${GITHUB_ACTION_PATH}"/cache_files.sh \
#  system_files_snapshot_01.txt \
#  system_files_snapshot_02.txt \
#  system_files_snapshot_new_files.txt

ls -lha /home/runner/work/_temp/

ls -lhaR /home/runner/work/_temp/

echo "# ----------------------------------------------------------"

"${GITHUB_ACTION_PATH}"/cache_node.sh

echo "# ----------------------------------------------------------"
