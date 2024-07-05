function fo2 --wraps=cd\ \~/.steam/steam/steamapps/common/Fallout\\\ 2/\ \&\&\nWINEDLLOVERRIDES=\'ddraw.dll=n,b\'\ wine\ fallout2.exe --description alias\ fo2=cd\ \~/.steam/steam/steamapps/common/Fallout\\\ 2/\ \&\&\nWINEDLLOVERRIDES=\'ddraw.dll=n,b\'\ wine\ fallout2.exe
  cd ~/.steam/steam/steamapps/common/Fallout\ 2/ &&
WINEDLLOVERRIDES='ddraw.dll=n,b' wine fallout2.exe $argv; 
end
