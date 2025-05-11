CC=clang
SRC=src/hello.c

TARGET_FLAGS_DEFAULT=

TARGET_FLAGS=$(TARGET_FLAGS_DEFAULT)
OUT=$(OUT_DEFAULT)

!IF "$(TARGET_OS)" == "Darwin"
TARGET_FLAGS=-target x86_64-apple-darwin --sysroot=$(MACOSX_SDK_PATH) -lz -fuse-ld=lld
OUT=hello
!ENDIF

!IF "$(TARGET_OS)" == "Windows"
TARGET_FLAGS=-target x86_64-pc-windows-msvc lib/zlib.lib
OUT=hello.exe
!ENDIF

!IF "$(TARGET_OS)" == "Linux"
TARGET_FLAGS=-target x86_64-linux-gnu -lz
OUT=hello
!ENDIF

all:
    @$(CC) $(SRC) $(TARGET_FLAGS) -o $(OUT)
    @echo [Build] Successful

clean:
    !IF "$(TARGET_OS)" == "Windows"
        cmd /c del $(OUT)
    !ELSE
        rm -f $(OUT)
    !ENDIF