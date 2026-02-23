@echo off
where ffmpeg >nul
IF %ERRORLEVEL% EQU 0 (
  echo stripping metadata from *.mp4 recursively...
  setlocal disabledelayedexpansion
  for /R %%a in (*.mp4) do (
    set fname=%%a
    setlocal enabledelayedexpansion
    set fnamenew=!fname:~0,-4!-clean.mp4
    call ffmpeg -i "!fname!" -map_metadata -1 -codec copy "!fnamenew!"
    del "!fname!"
    move "!fnamenew!" "!fname!"
    endlocal
  )
  endlocal
) else (
  echo ffmpeg not in path, aborting...
  pause
)
