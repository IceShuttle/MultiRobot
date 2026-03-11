RUNTIME ?=podman
IMAGE ?=multirobot
GUI_SCRIPT = gui_$(RUNTIME).sh

NVIDIA ?= 0
ifeq ($(NVIDIA),0)
NVIDIA_FLAGS :=
else ifeq ($(NVIDIA),1)
# Simple 'all' is the clearest and widely supported form
NVIDIA_FLAGS := --gpus all
else ifeq ($(NVIDIA),2)
# Select a specific device and capabilities. Adjust device index as needed.
NVIDIA_FLAGS := --gpus all,capabilities=compute,utility,graphics
else
$(error Invalid NVIDIA value '$(NVIDIA)'. Use 0, 1 or 2)
endif

FLAGS := $(FLAGS) $(NVIDIA_FLAGS)

sim-image:
	$(RUNTIME) build -t $(IMAGE) .

sim: sim-image
	@echo $(FLAGS)
	IMG=$(IMAGE) CMD="/environment/run_sim.sh" ./$(GUI_SCRIPT)


