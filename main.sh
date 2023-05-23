#!/bin/bash
set -e

if [ -z $AC_REPEATO_WORKSPACE_DIR ]; then
    echo 'Missing input: AC_REPEATO_WORKSPACE_DIR'
    exit 1
fi

if [ -z $AC_REPEATO_BATCH_ID ]; then
    echo 'Missing input: AC_REPEATO_BATCH_ID'
    exit 1
fi

if [ -z $AC_REPEATO_CLI_VER ]; then
    echo "Repeato CLI version not specified, using latest"
else
    echo "Repeato CLI version: $AC_REPEATO_CLI_VER"
fi

# Start repeato batch run tests & upload report
npm i -g @repeato/cli-testrunner@"${AC_REPEATO_CLI_VER:-latest}"

cli-testrunner --licenseKey "${AC_REPEATO_LIC_KEY}" --workspaceDir "$AC_REPOSITORY_DIR/$AC_REPEATO_WORKSPACE_DIR" --batchId "${AC_REPEATO_BATCH_ID}" --outputDir "${AC_OUTPUT_DIR}/repeato-test-results" --logLevel "${AC_REPEATO_LOG_LEVEL}"
if [ $? -eq 0 ] 
then 
  echo "Repeato CLI test runner completed successfully." 
else 
  echo "Error in Repeato CLI test runner." 
  exit 1
fi

zip -r repeato_reports_$AC_REPEATO_BATCH_ID.zip $AC_OUTPUT_DIR/repeato-test-results
if [ $? -eq 0 ]; then 
  echo "Repeato report zip compression completed successfully." 
else 
  echo "Error in Repeato report zip compression." 
  exit 1
fi

mkdir -p $AC_OUTPUT_DIR/repeato-reports
cp repeato_reports_$AC_REPEATO_BATCH_ID.zip $AC_OUTPUT_DIR/repeato-reports/batch_report_$AC_REPEATO_BATCH_ID.zip
cp jUnitReport.xml $AC_OUTPUT_DIR/repeato-reports/UnitTest.xml

echo "AC_TEST_RESULT_PATH=$AC_OUTPUT_DIR/repeato-reports" >> $AC_ENV_FILE_PATH
echo "AC_REPEATO_REPORT=$AC_OUTPUT_DIR/repeato-reports/UnitTest.xml" >> $AC_ENV_FILE_PATH
echo "AC_REPEATO_JUNIT_REPORT=$AC_OUTPUT_DIR/repeato-reports/batch_report_$AC_REPEATO_BATCH_ID.zip" >> $AC_ENV_FILE_PATH
