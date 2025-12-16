
#define STB_IMAGE_WRITE_IMPLEMENTATION

#include <fstream>
#include <iostream>
#include <cmath>

#include "file2png.h"
#include "../lib/stb_image_write.h"


int main(int argc, char* argv[])
{
    if (argc < 2) {
        std::cerr << "Usage: file2png <file>\n";
        return 1;
    }

    auto binaryData = readBinary(argv[1]);
    topng(binaryData);
}


std::vector<std::uint8_t> readBinary(const std::string& path)
{
    std::ifstream file(path, std::ios::binary);
    if (!file)
        throw std::runtime_error("Failed to open file");

    return std::vector<std::uint8_t>(std::istreambuf_iterator<char>(file), std::istreambuf_iterator<char>());
}

int closestSquare(int n)
{
    return static_cast<int>(std::ceil(std::sqrt(n))) + 1;
}

void topng(const std::vector<std::uint8_t>& data)
{
    const size_t bytes_per_pixel = 4;
    size_t pixel_count = (data.size() + bytes_per_pixel - 1) / bytes_per_pixel;

    int side = static_cast<int>(std::ceil(std::sqrt(pixel_count)));

    std::vector<std::uint8_t> pixels(side * side * 4, 0);

    std::copy(data.begin(), data.end(), pixels.begin());

    stbi_write_png(
        "out.png",
        side,
        side,
        4,
        pixels.data(),
        side * 4
    );
}