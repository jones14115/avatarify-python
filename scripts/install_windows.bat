@echo off

REM Check prerequisites
call conda --version >nul 2>&1 && ( echo conda found ) || ( echo conda not found. Please refer to the README and install Miniconda. && exit /B 1)

call scripts/settings_windows.bat

REM Create environment with Python 3.10 (not 3.7)
call conda create -y -n %CONDA_ENV_NAME% python=3.10
call conda activate %CONDA_ENV_NAME%

REM Install compatible numpy and scikit-image
call conda install -y numpy=1.24.3 scikit-image scikit-learn scipy -c conda-forge

REM Skip PyTorch installation - use your existing PyTorch 2.0.1+cu118
REM call conda install -y pytorch==1.7.1 torchvision cudatoolkit=11.0 -c pytorch
echo Using existing PyTorch 2.0.1+cu118

REM Install git
call conda install -y -c anaconda git

REM ###FOMM###
call rmdir fomm /s /q
call git clone https://github.com/alievk/first-order-model.git fomm

REM Install remaining requirements (excluding torch/torchvision)
call pip install pyyaml face-alignment imageio imageio-ffmpeg pyvirtualcam requests opencv-python==4.8.1.78

echo Installation complete with PyTorch 2.0.1+cu118