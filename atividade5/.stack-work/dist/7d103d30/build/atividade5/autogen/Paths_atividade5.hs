{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_atividade5 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\atividade5\\.stack-work\\install\\bf6b262a\\bin"
libdir     = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\atividade5\\.stack-work\\install\\bf6b262a\\lib\\x86_64-windows-ghc-8.4.3\\atividade5-0.1.0.0-EcsrZw2GXRW57Cm8pA0pBv-atividade5"
dynlibdir  = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\atividade5\\.stack-work\\install\\bf6b262a\\lib\\x86_64-windows-ghc-8.4.3"
datadir    = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\atividade5\\.stack-work\\install\\bf6b262a\\share\\x86_64-windows-ghc-8.4.3\\atividade5-0.1.0.0"
libexecdir = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\atividade5\\.stack-work\\install\\bf6b262a\\libexec\\x86_64-windows-ghc-8.4.3\\atividade5-0.1.0.0"
sysconfdir = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\atividade5\\.stack-work\\install\\bf6b262a\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "atividade5_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "atividade5_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "atividade5_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "atividade5_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "atividade5_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "atividade5_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
