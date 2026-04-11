MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: proj 

proj:
	xcodegen generate && open AlgebraGo.xcodeproj
