#!/bin/sh

cd "$GITHUB_WORKSPACE/${INPUT_DIRECTORY}"

echo "Running Code Sniffer..."
/usr/local/bin/phpcs.phar ${INPUT_PHPCS_ARGS:-\.}
EXIT_CODE1=$?
echo "Code Sniffer finished. Exit code: ${EXIT_CODE1}"


echo "Running Mess Detector..."
/usr/local/bin/phpmd.phar ${INPUT_PHPMD_ARGS:-\.} > /tmp/phpmd-report.txt
cat /tmp/phpmd-report.txt #exits with 255 if we dont send to file and cat the file
EXIT_CODE2=$?
echo "Mess Detector finished. Exit code: ${EXIT_CODE2}"

if [ $EXIT_CODE1 != 0 ] || [ $EXIT_CODE2 != 0 ] ; then
  exit 1;
fi
