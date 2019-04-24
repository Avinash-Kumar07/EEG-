%%
close all;
clear;
clc;
%%
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end