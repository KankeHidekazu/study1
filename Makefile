#Set this to @ to keep the makefile quiet
SILENCE = @

#---- Outputs ----#
##COMPONENT_NAME = Project
COMPONENT_NAME = simpleCppProject
TARGET_LIB = \
	lib/lib$(COMPONENT_NAME).a
	
TEST_TARGET = \
	$(COMPONENT_NAME)_tests

#--- Inputs ----#
PROJECT_HOME_DIR = .
ifeq "$(CPPUTEST_HOME)" ""
    CPPUTEST_HOME = /usr/local/Cellar/cpputest/3.7.2
endif
CPPUNIT_HOME = ../cppunit
CPP_PLATFORM = Gcc

#CFLAGS are set to override malloc and free to get memory leak detection in C programs
CFLAGS = -Dmalloc=cpputest_malloc -Dfree=cpputest_free
CPPFLAGS =
#GCOVFLAGS = -fprofile-arcs -ftest-coverage

#SRC_DIRS is a list of source directories that make up the target library
#If test files are in these directories, their IMPORT_TEST_GROUPs need
#to be included in main to force them to be linked in.  By convention
#put them into an AllTests.h file in each directory
SRC_DIRS = \
	src

#TEST_SRC_DIRS is a list of directories including 
# - A test main (AllTests.cpp by convention)
# - OBJ files in these directories are included in the TEST_TARGET
# - Consequently - AllTests.h containing the IMPORT_TEST_GROUPS is not needed
# - 
TEST_SRC_DIRS = \
	tests

#includes for all compiles	
INCLUDES =\
  -I.\
  -Iinclude\
  -I$(CPPUTEST_HOME)/include/

#Flags to pass to ld
LDFLAGS += $(CPPUNIT_HOME)/lib/libcppunit.a
CPPUTEST_WARNINGFLAGS = -Wall -Werror -Wswitch-default 
CPPUTEST_WARNINGFLAGS += -Wconversion -Wswitch-enum 
CPPUTEST_WARNINGFLAGS += -Wno-date-time

#lcov の結果を表示するのに利用したいブラウザ名
HTML_BROWSER = safari

.PHONY: lcov
lcov:
	$(SILENCE) echo "lcov procedures..."
	$(SILENCE) mkdir -p ./lcov
	$(SILENCE) for d in $(SRC_DIRS) ; do \
  lcov -b . -c -d $(CPPUTEST_OBJS_DIR)/$$d \
  -o lcov/lcov_report.info; \
  done
	$(SILENCE)genhtml -o ./lcov lcov/lcov_report.info

.PHONY: check_coverage
check_coverage: clean
	$(MAKE) CPPUTEST_USE_GCOV=Y gcov
	$(MAKE) lcov
	$(SILENCE) if [ -n "$(HTML_BROWSER)" ]; then \
  open -a $(HTML_BROWSER) lcov/index.html; \
     fi
	
#include $(CPPUTEST_HOME)/build/ComponentMakefile
include ./scripts/MakefileWorker.mk
