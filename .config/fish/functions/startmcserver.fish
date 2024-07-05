function startmcserver --wraps='java -Xmx6G -Xms6G -jar ~/minecraft/server/currentpatch/server.jar nogui' --wraps='cd ~/minecraft/server/currentpatch && java -Xmx6G -Xms6G -jar server.jar nogui' --description 'alias startmcserver=cd ~/minecraft/server/currentpatch && java -Xmx6G -Xms6G -jar server.jar nogui'
  cd ~/minecraft/server/currentpatch && java -Xmx6G -Xms6G -jar server.jar nogui $argv; 
end
