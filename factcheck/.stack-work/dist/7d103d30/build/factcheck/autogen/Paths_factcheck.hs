{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_factcheck (
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

bindir     = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\factcheck\\.stack-work\\install\\fa6a03d3\\bin"
libdir     = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\factcheck\\.stack-work\\install\\fa6a03d3\\lib\\x86_64-windows-ghc-8.4.3\\factcheck-0.1.0.0-1r5bpkTnKnJF3w9xg0wM8l-factcheck"
dynlibdir  = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\factcheck\\.stack-work\\install\\fa6a03d3\\lib\\x86_64-windows-ghc-8.4.3"
datadir    = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\factcheck\\.stack-work\\install\\fa6a03d3\\share\\x86_64-windows-ghc-8.4.3\\factcheck-0.1.0.0"
libexecdir = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\factcheck\\.stack-work\\install\\fa6a03d3\\libexec\\x86_64-windows-ghc-8.4.3\\factcheck-0.1.0.0"
sysconfdir = "C:\\Users\\jorge\\OneDrive\\Documentos\\UFABC\\Paradigmas de Programa\231\227o\\paradigmas_prog\\factcheck\\.stack-work\\install\\fa6a03d3\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "factcheck_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "factcheck_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "factcheck_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "factcheck_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "factcheck_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "factcheck_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
