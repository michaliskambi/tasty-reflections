{
  Copyright 2014-2014 Michalis Kamburelis.

  This file is part of "Tasty Reflections".

  "Tasty Reflections" is free software; see the file COPYING.GPL2.txt,
  included in this distribution, for details about the copyright.

  "Tasty Reflections" is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  ----------------------------------------------------------------------------
}

{$apptype GUI}

{ Main program for a standalone version of the game.
  This allows you to compile the same game game (in Game unit)
  as a normal, standalone executable for normal OSes (Linux, Windows, MacOSX...). }
program tasty_reflections;
uses CastleWindow, CastleConfig, Game;
begin
  Window.FullScreen := true;
  Window.ParseParameters;

  Config.Load;
  Application.Initialize;
  Window.OpenAndRun;
  Config.Save;
end.
