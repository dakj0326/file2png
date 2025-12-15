CXX := g++
CXXFLAGS := -std=c++20 -Wall -Wextra -O2
INCLUDES := -Iinclude

BUILDDIR := builds
OBJDIR   := $(BUILDDIR)/obj

# Programs
file2png_SRC := $(shell find file2png -name "*.cpp")
png2file_SRC := $(shell find png2file -name "*.cpp")
bin2analyzer_SRC := $(shell find bin2analyzer -name "*.cpp")

file2png_OBJ := $(patsubst %.cpp,$(OBJDIR)/%.o,$(file2png_SRC))
png2file_OBJ := $(patsubst %.cpp,$(OBJDIR)/%.o,$(png2file_SRC))
bin2analyzer_OBJ := $(patsubst %.cpp,$(OBJDIR)/%.o,$(bin2analyzer_SRC))

file2png_BIN := $(BUILDDIR)/file2png
png2file_BIN := $(BUILDDIR)/png2file
bin2analyzer_BIN := $(BUILDDIR)/bin2analyzer

all: $(file2png_BIN) $(png2file_BIN) $(bin2analyzer_BIN)

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

# Link
$(file2png_BIN): $(file2png_OBJ) | $(BUILDDIR)
	$(CXX) $^ -o $@

$(png2file_BIN): $(png2file_OBJ) | $(BUILDDIR)
	$(CXX) $^ -o $@

$(bin2analyzer_BIN): $(bin2analyzer_OBJ) | $(BUILDDIR)
	$(CXX) $^ -o $@

# Compile rule — THIS is the key fix
$(OBJDIR)/%.o: %.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

clean:
	rm -rf $(BUILDDIR)
