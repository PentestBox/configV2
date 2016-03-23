:: Init Script for cmd.exe
:: Sets some nice defaults
:: Created as part of PentestBox project

:: Find root dir
@if not defined pentestbox_ROOT (
    for /f %%i in ("%ConEmuDir%\..\..") do @set pentestbox_ROOT=%%~fi
)

:: Change the prompt style
@prompt $E[1;32;40m$P$S{git}$S$_$E[1;30;40m{lamb}$S$E[0m

:: Pick right version of clink
@if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set architecture=86
) else (
    set architecture=64
)

:: Run clink
@"%pentestbox_ROOT%\base\clink\clink_x%architecture%.exe" inject --quiet --profile "%pentestbox_ROOT%\config"

:: Prepare for msysgit

:: I do not even know, copypasted from their .bat
@set PLINK_PROTOCOL=ssh
@if not defined TERM set TERM=cygwin

:: Enhance Path
@set git_install_root=%pentestbox_ROOT%\base\PortableGit
@set PATH=%pentestbox_ROOT%\bin;%git_install_root%\bin;%git_install_root%\mingw32\bin;%git_install_root%\usr\bin;%git_install_root%\cmd;%git_install_root%\share\vim\vim74;%PATH%;%pentestbox_ROOT%\base\curl\bin;%pentestbox_ROOT%\base\python;%pentestbox_ROOT%\base\ruby\bin;%pentestbox_ROOT%\base\ruby_devkit\bin;%pentestbox_ROOT%\base\ruby_devkit\mingw\bin;%pentestbox_ROOT%\base\strawberry-perl\perl\bin;%pentestbox_ROOT%\base\strawberry-perl\c\bin;%pentestbox_ROOT%\base\strawberry-perl\;%pentestbox_ROOT%\bin\nmap;%pentestbox_ROOT%\base\jdk1.8.0_74\bin;%pentestbox_ROOT%\base\jdk1.8.0_74\jre\bin;%pentestbox_ROOT%\base\jdk1.8.0_74\jre\lib;%pentestbox_ROOT%\bin\aircrack-ng-1.2-rc4-win\bin\32bit;%pentestbox_ROOT%\bin\password_attacks\rainbowcrack;%pentestbox_ROOT%\bin\androidsecurity\dex2jar;%pentestbox_ROOT%\bin\androidsecurity\sdk\platform-tools;%pentestbox_ROOT%\base\python\Scripts;%pentestbox_ROOT%\bin\7za;%pentestbox_ROOT%\bin\wget
@set PYTHONPATH=%pentestbox_ROOT%\base\python\Lib\site-packages
@set CURL_CA_BUNDLE=C:\PentestBox\base\curl\bin\ca-bundle.crt
@set SSL_CERT_FILE=C:\PentestBox\base\curl\bin\cacert.pem
:: Add aliases
@doskey /macrofile="%pentestbox_ROOT%\config\aliases"
:: Custom aliases
@if exist "%pentestbox_ROOT%\bin\customtools\customaliases" (
	@doskey /macrofile="%pentestbox_ROOT%\bin\customtools\customaliases"
)
:: Set home path
@if not defined HOME set HOME=%USERPROFILE%

@if defined pentestbox_START (
    @cd /d "%pentestbox_START%"
) else (
    @if "%CD%\" == "%pentestbox_ROOT%" (
        @cd /d "%HOME%"
    )
)
