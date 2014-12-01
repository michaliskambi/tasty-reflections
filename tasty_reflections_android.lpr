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

{ Library to run the game on Android. }
library tasty_reflections_android;
uses CastleAndroidNativeAppGlue, Game;
exports ANativeActivity_onCreate;
end.
