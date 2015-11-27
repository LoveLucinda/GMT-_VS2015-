
rem //////////////GMT script program/////////////////////////
rem Function: Cut a areal data from netCDF gride file
rem Zhikuiguo,Second Institute of Oceanography.SOA
rem			  China University of Geosciences, IGG
rem 2015-11-27
rem Notice: The inputfile

rem _______Input and Output paremeter ___________________________________________________
set infile_nc=H:\Study\1-��ʿ����\2_����ӡ��������\1-��������׼��\12-���ˮ׼�����\Geoid_EGM96
set RANGE=-20/80/-65/-20
set outfile_nc_cutted=%infile_nc%_cut
set Extension_name=.nc
rem __________________________________________________ __________________________________
gmt grdcut %infile_nc%%Extension_name% -G%outfile_nc_cutted%%Extension_name% -R%RANGE% -V
