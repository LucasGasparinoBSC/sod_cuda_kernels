message("-- Selecting compiler Ops...")

# Set library types to be shared
set(LIBRARY_TYPE SHARED)

# Set a default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# Set C/C++ standard
set(CMAKE_CXX_STANDARD 17)

# Set the CUDA architecture for NVCC
set(CMAKE_CUDA_ARCHITECTURES 61)

# Define specific compiler flags
if(CMAKE_C_COMPILER_ID STREQUAL "NVHPC" OR CMAKE_C_COMPILER_ID STREQUAL "PGI")
	message("-- NVHPC compiler detected")
	# Common NVHPC+MPI flags
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -cpp -lstdc++ -lnvToolsExt -cuda -Minfo=accel -lnvToolsExt")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -cpp -lstdc++ -lnvToolsExt -cuda -Minfo=accel -lnvToolsExt")
	set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -lnvToolsExt")
	# Debug
	set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g -O0 -Minform=inform -C -Mbounds -Mchkptr -traceback -Ktrap=fp,unf")
	set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g -O0 -Minform=inform -C -Mbounds -Mchkstk -traceback -Ktrap=fp,unf")
	set(CMAKE_CUDA_FLAGS_DEBUG "${CMAKE_CUDA_FLAGS_DEBUG} -g -G -O0")
	# Release
	set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -fast")
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -fast")
	set(CMAKE_CUDA_FLAGS_RELEASE "${CMAKE_CUDA_FLAGS_RELEASE} -O3")
	# GPU options
	message("IMPORTANT: Verify the device compute capability!!!")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -gpu=cc61,lineinfo -cuda")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -gpu=cc61,lineinfo -cuda")
else()
	message("this shit: " ${CMAKE_C_COMPILER_ID})
	message(FATAL_ERROR "Unknown compiler")
endif()

# Adjust stringg so ; is removed from the command
string(REPLACE ";" " " CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
string(REPLACE ";" " " CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
string(REPLACE ";" " " CMAKE_Fortran_FLAGS "${CMAKE_CUDA_FLAGS}")
string(REPLACE ";" " " CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}")
string(REPLACE ";" " " CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}")
string(REPLACE ";" " " CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_CUDA_FLAGS_DEBUG}")
string(REPLACE ";" " " CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}")
string(REPLACE ";" " " CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}")
string(REPLACE ";" " " CMAKE_Fortran_FLAGS_RELEASE "${CMAKE_CUDA_FLAGS_RELEASE}")
