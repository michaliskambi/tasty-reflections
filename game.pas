{
  Copyright 2014-2014 Michalis Kamburelis.

  This file is part of "Tasty Reflections".

  "Tasty Reflections" is free software; see the file COPYING.txt,
  included in this distribution, for details about the copyright.

  "Tasty Reflections" is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  ----------------------------------------------------------------------------
}

{ Implements the game logic, independent from Android / standalone. }
unit Game;

{ $define TOUCH_INTERFACE} // useful to test TOUCH_INTERFACE on desktops
{$ifdef ANDROID} {$define TOUCH_INTERFACE} {$endif}
{$ifdef iOS}     {$define TOUCH_INTERFACE} {$endif}

interface

uses CastleWindowTouch, CastleLevels, CastlePlayer;

var
  Window: TCastleWindowTouch;
  SceneManager: TGameSceneManager; //< same thing as Window.SceneManager
  Player: TPlayer; //< same thing as Window.SceneManager.Player

implementation

uses SysUtils,
  CastleLog, CastleWindow, CastleProgress, CastleWindowProgress,
  CastleResources, CastleCameras, CastleKeysMouse, CastleFilesUtils;

{ routines ------------------------------------------------------------------- }

{ One-time initialization. }
procedure ApplicationInitialize;
begin
  {$ifndef MSWINDOWS} { Under Windows, log requires stderr. }
  InitializeLog;
  {$endif}

  Progress.UserInterface := WindowProgressInterface;

  Resources.LoadFromFiles; // not used for now
  //Levels.LoadFromFiles;
  // to work on Android, use Levels.AddFromFile, not Levels.LoadFromFiles
  Levels.AddFromFile(ApplicationData('levels/tower/level.xml'));

  SceneManager := Window.SceneManager;

  Player := TPlayer.Create(SceneManager);
  SceneManager.Items.Add(Player);
  SceneManager.Player := Player;
end;

procedure WindowOpen(Container: TUIContainer);
begin
  SceneManager.LoadLevel('tower');
  {$ifdef TOUCH_INTERFACE}
  Window.AutomaticTouchInterface := true;
  Player.EnableCameraDragging := true;
  {$else}
  Player.Camera.MouseLook := true;
  {$endif}
end;

procedure WindowPress(Container: TUIContainer; const Event: TInputPressRelease);
begin
  if Event.IsKey(K_F5) then
    Window.SaveScreen(FileNameAutoInc(ApplicationName + '_screen_%d.png'));
end;

function MyGetApplicationName: string;
begin
  Result := 'tasty_reflections';
end;

initialization
  { This should be done as early as possible to mark our log lines correctly. }
  OnGetApplicationName := @MyGetApplicationName;

  { initialize Application callbacks }
  Application.OnInitialize := @ApplicationInitialize;

  { create Window and initialize Window callbacks }
  Window := TCastleWindowTouch.Create(Application);
  Window.OnOpen := @WindowOpen;
  Window.OnPress := @WindowPress;
  Application.MainWindow := Window;
end.
