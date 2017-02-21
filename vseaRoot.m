function rootPath = vseaRoot()
%% Get the path to VirtualScenesExampleAssets.
%
% rootPath = vseaRoot() returns the absolute path to VirtualScenesExampleAssets,
% based on the location of this file, vseaRoot.m.
%
% 2016 RenderToolbox team

fullPathHere = mfilename('fullpath');
rootPath = fileparts(fullPathHere);

