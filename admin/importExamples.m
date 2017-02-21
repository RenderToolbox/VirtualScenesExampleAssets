%% Admin script to import initial example assets.
%
% Most users don't need to run this script.
%
% This script imports assets from external sources, to make up our example
% assets.
%
% 2016 RenderToolbox team

clear;
location = 'examples';
tbUse({'VirtualScenesAssets', 'RenderToolbox4', 'VirtualScenes'}, 'reset', 'full');


%% Import spectra from RenderToolbox.

% d65 illuminant
d65 = fullfile(rtbRoot(), 'RenderData', 'D65.spd');
vsaPut('Illuminants', 'D65', ...
    'location', location, ...
    'files', {d65}, ...
    'ifConflict', 'replace');

% metal indices of refraction from PBRT
metalsFolder = fullfile(rtbRoot(), 'RenderData', 'PBRTMetals');
metalsFiles = rtbFindFiles('root', metalsFolder, 'filter', '\.spd$');
metalsReadme = fullfile(metalsFolder, 'README.txt');
vsaPut('IndicesOfRefraction', 'PBRTMetals', ...
    'location', location, ...
    'files', metalsFiles, ...
    'extras', {metalsReadme}, ...
    'ifConflict', 'replace');

% color checker reflectances
mccFolder = fullfile(rtbRoot(), 'RenderData', 'Macbeth-ColorChecker');
mccFiles = rtbFindFiles('root', mccFolder, 'filter', '\.spd$');
mccReadme = fullfile(mccFolder, 'README.txt');
vsaPut('Reflectances', 'ColorChecker', ...
    'location', location, ...
    'files', mccFiles, ...
    'extras', {mccReadme}, ...
    'ifConflict', 'replace');


%% Import 3D models and textures from an older Virtual Scenes repo.

% base scenes
textureFolder = fullfile(VirtualScenesRoot(), 'ModelRepository', 'BaseScenes');
modelsFolder = fullfile(textureFolder, 'Models');
licensesFolder = fullfile(textureFolder, 'Licenses');
matFiles = rtbFindFiles('root', textureFolder, 'filter', '\.mat$');
nAssets = numel(matFiles);
for aa = 1:nAssets
    modelInfo = load(matFiles{aa});
    assetInfo = rmfield(modelInfo.metadata, 'relativePath');
    
    modelFiles = rtbFindFiles('root', modelsFolder, 'filter', assetInfo.name);
    
    licenseFolder = fullfile(licensesFolder, assetInfo.name);
    extraFiles = rtbFindFiles('root', licenseFolder);
    
    vsaPut('BaseScenes', assetInfo.name, ...
        'location', location, ...
        'files', modelFiles, ...
        'extras', extraFiles, ...
        'ifConflict', 'replace', ...
        assetInfo);
end

% objects
textureFolder = fullfile(VirtualScenesRoot(), 'ModelRepository', 'Objects');
modelsFolder = fullfile(textureFolder, 'Models');
licensesFolder = fullfile(textureFolder, 'Licenses');
matFiles = rtbFindFiles('root', textureFolder, 'filter', '\.mat$');
nAssets = numel(matFiles);
for aa = 1:nAssets
    modelInfo = load(matFiles{aa});
    assetInfo = rmfield(modelInfo.metadata, 'relativePath');
    
    modelFiles = rtbFindFiles('root', modelsFolder, 'filter', assetInfo.name);
    
    licenseFolder = fullfile(licensesFolder, assetInfo.name);
    extraFiles = rtbFindFiles('root', licenseFolder);
    
    vsaPut('Objects', assetInfo.name, ...
        'location', location, ...
        'files', modelFiles, ...
        'extras', extraFiles, ...
        'ifConflict', 'replace', ...
        assetInfo);
end

% textures
textureFolder = fullfile(VirtualScenesRoot(), 'MiscellaneousData', 'Textures');
textureFiles = rtbFindFiles('root', textureFolder, 'filter', '\.jpg$');
licenseFile = fullfile(textureFolder, 'image-license-notice.txt');
vsaPut('Textures', 'OpenGameArt', ...
    'location', location, ...
    'files', textureFiles, ...
    'extras', {licenseFile}, ...
    'ifConflict', 'replace');
