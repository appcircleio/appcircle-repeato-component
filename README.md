# Appcircle _Repeato Test Runner_ component

You can execute Repeato tests before deploying your app build.

## Required Inputs

- `AC_REPEATO_WORKSPACE_DIR`: Workspace Path. Repeato test runner need workspace path for setting up the workspace before executing batch. Ex: `./mypath` 
- `AC_REPEATO_BATCH_ID`: Repeato Batch ID. Provide batch id for the tests execution.
- `AC_REPEATO_LIC_KEY`: Repeato License Key. Provide license key for the tests execution.
- `AC_REPEATO_LOG_LEVEL`: Log Level. Switch to DEBUG if you have troubles running your batches. This prints a lot of additional information to the log.

## Optional Inputs

- `AC_REPEATO_CLI_VER`: Repeato CLI Version. Set the Repeato CLI version compatible to your workspace tests.

## Output Variables

- `AC_REPEATO_REPORT`: Repeato Batch Report Zip File. Repeato batch report of executed tests.
- `AC_REPEATO_JUNIT_REPORT`: Repeato JUnit XML File. Repeato executed tests report in JUnit XML format.
- `AC_TEST_RESULT_PATH`: Output Path. The directory where your Junit XML report will be written to.
