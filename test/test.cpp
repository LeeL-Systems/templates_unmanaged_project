
#ifndef QUALITY_TEST_TEST_CPP_
#define QUALITY_TEST_TEST_CPP_

#include <quality/quality.hpp>
#include "../project_name.hpp"

#define QA_PROPJECTNAME project_name

QA_TEST_START

QA_INITIALIZATION_START

QA_SETUP()
{
    QA_REPORT_TESTMETHOD("Setup");
}

QA_TEARDOWN()
{
    QA_REPORT_TESTMETHOD("TearDown");
}

QA_INITIALIZATION_END

QA_METHOD(Tutorial)
{
    QA_REPORT_TESTMETHOD("Tutorial");
    QA_CHECK_AREEQUAL(0, 0, "Unexpected value");
    QA_CHECK_ARENOTEQUAL(0, 1, "Unexpected value");
}

QA_TEST_END

#endif  // QUALITY_TEST_TEST_CPP_
