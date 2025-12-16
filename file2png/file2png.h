
#pragma once

#include <vector>
#include <cstdint>
#include <string>

std::vector<std::uint8_t> readBinary(const std::string& path);
void topng(const std::vector<std::uint8_t>& data);
int closestSquare(int n);