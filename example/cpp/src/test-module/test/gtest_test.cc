#include <iostream>
#include "gtest/gtest.h"
#include "../test.h"

TEST(ArrowConv, ArrowTest) {
    EXPECT_EQ(true, testArrow::function());
}