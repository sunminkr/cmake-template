#include "gtest/gtest.h"
#include "../test.cc"

TEST(ArrowConv, ArrowTest) {
    EXPECT_EQ(1, function());
    EXPECT_EQ(1.00, function());
}