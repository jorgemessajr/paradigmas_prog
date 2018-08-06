{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_Atividade7 (
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

bindir     = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\Atividade7\\.stack-work\\install\\620260b6\\bin"
libdir     = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\Atividade7\\.stack-work\\install\\620260b6\\lib\\x86_64-windows-ghc-8.4.3\\Atividade7-0.1.0.0-2oRrHoqJN399qXIu5WHWE1-Atividade7"
dynlibdir  = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\Atividade7\\.stack-work\\install\\620260b6\\lib\\x86_64-windows-ghc-8.4.3"
datadir    = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\Atividade7\\.stack-work\\install\\620260b6\\share\\x86_64-windows-ghc-8.4.3\\Atividade7-0.1.0.0"
libexecdir = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\Atividade7\\.stack-work\\install\\620260b6\\libexec\\x86_64-windows-ghc-8.4.3\\Atividade7-0.1.0.0"
sysconfdir = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\Atividade7\\.stack-work\\install\\620260b6\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Atividade7_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Atividade7_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Atividade7_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Atividade7_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Atividade7_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Atividade7_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
