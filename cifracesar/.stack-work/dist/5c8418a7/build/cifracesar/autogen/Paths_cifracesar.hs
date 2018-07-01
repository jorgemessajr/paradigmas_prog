{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_cifracesar (
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

bindir     = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\cifracesar\\.stack-work\\install\\66f269a2\\bin"
libdir     = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\cifracesar\\.stack-work\\install\\66f269a2\\lib\\x86_64-windows-ghc-8.2.2\\cifracesar-0.1.0.0-CSz2PSRbBcI7rFpwRzTgwd-cifracesar"
dynlibdir  = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\cifracesar\\.stack-work\\install\\66f269a2\\lib\\x86_64-windows-ghc-8.2.2"
datadir    = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\cifracesar\\.stack-work\\install\\66f269a2\\share\\x86_64-windows-ghc-8.2.2\\cifracesar-0.1.0.0"
libexecdir = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\cifracesar\\.stack-work\\install\\66f269a2\\libexec\\x86_64-windows-ghc-8.2.2\\cifracesar-0.1.0.0"
sysconfdir = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\cifracesar\\.stack-work\\install\\66f269a2\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "cifracesar_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "cifracesar_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "cifracesar_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "cifracesar_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "cifracesar_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "cifracesar_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
