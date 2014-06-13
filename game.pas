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

interface

uses CastleWindowTouch, CastleLevels, CastlePlayer;

var
  Window: TCastleWindowTouch;
  SceneManager: TGameSceneManager; //< same thing as Window.SceneManager
  Player: TPlayer; //< same thing as Window.SceneManager.Player

implementation

uses SysUtils,
  CastleLog, CastleWindow, CastleProgress, CastleWindowProgress,
  CastleResources, CastleCameras;

{ routines ------------------------------------------------------------------- }

{ One-time initialization. }
procedure ApplicationInitialize;
begin
  {$ifndef MSWINDOWS} { Under Windows, log requires stderr. }
  InitializeLog;
  {$endif}

  Progress.UserInterface := WindowProgressInterface;

  Resources.LoadFromFiles; // not used for now
  Levels.LoadFromFiles;

  SceneManager := Window.SceneManager;

  Player := TPlayer.Create(SceneManager);
  SceneManager.Items.Add(Player);
  SceneManager.Player := Player;
end;

procedure WindowOpen(Container: TUIContainer);
begin
  SceneManager.LoadLevel('tower');
  (SceneManager.Camera as TWalkCamera).MouseLook := true;
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
  Application.MainWindow := Window;
end.
