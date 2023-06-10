CXX := g++
EXE ?= stratego-server

SRC_DIR ?= src
BLD_DIR ?= build
INC_DIR := $(shell find $(SRC_DIR) -type d)

SRCS := $(shell find $(SRC_DIR) -name *.cpp)
OBJS := $(SRCS:%=$(BLD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

LDFLAGS :=
INC_FLAGS := $(addprefix -I,$(INC_DIR))
CXXFLAGS := $(LDFLAGS) -O2 $(INC_FLAGS) -Wall

.PHONY: all clean

all: $(EXE)

$(EXE): $(OBJS)
	$(CXX) $(CXXFLAGS) $(OBJS) -o $@

$(BLD_DIR)/%.cpp.o: %.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	-rm -r $(BLD_DIR)
	-rm $(EXE)
