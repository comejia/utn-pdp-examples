{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_primer_proyecto (
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

bindir     = "/home/cmejia/Desktop/projects/paradigmas-de-programacion-tps/primer-proyecto/.stack-work/install/x86_64-linux-tinfo6/70adee0cd7524337e3d206377de2764716cce9d7b7254525ba4c53f99e4eb694/8.8.2/bin"
libdir     = "/home/cmejia/Desktop/projects/paradigmas-de-programacion-tps/primer-proyecto/.stack-work/install/x86_64-linux-tinfo6/70adee0cd7524337e3d206377de2764716cce9d7b7254525ba4c53f99e4eb694/8.8.2/lib/x86_64-linux-ghc-8.8.2/primer-proyecto-0.1.0.0-2bhZicZ1fu1FZ743zRWPGF"
dynlibdir  = "/home/cmejia/Desktop/projects/paradigmas-de-programacion-tps/primer-proyecto/.stack-work/install/x86_64-linux-tinfo6/70adee0cd7524337e3d206377de2764716cce9d7b7254525ba4c53f99e4eb694/8.8.2/lib/x86_64-linux-ghc-8.8.2"
datadir    = "/home/cmejia/Desktop/projects/paradigmas-de-programacion-tps/primer-proyecto/.stack-work/install/x86_64-linux-tinfo6/70adee0cd7524337e3d206377de2764716cce9d7b7254525ba4c53f99e4eb694/8.8.2/share/x86_64-linux-ghc-8.8.2/primer-proyecto-0.1.0.0"
libexecdir = "/home/cmejia/Desktop/projects/paradigmas-de-programacion-tps/primer-proyecto/.stack-work/install/x86_64-linux-tinfo6/70adee0cd7524337e3d206377de2764716cce9d7b7254525ba4c53f99e4eb694/8.8.2/libexec/x86_64-linux-ghc-8.8.2/primer-proyecto-0.1.0.0"
sysconfdir = "/home/cmejia/Desktop/projects/paradigmas-de-programacion-tps/primer-proyecto/.stack-work/install/x86_64-linux-tinfo6/70adee0cd7524337e3d206377de2764716cce9d7b7254525ba4c53f99e4eb694/8.8.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "primer_proyecto_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "primer_proyecto_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "primer_proyecto_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "primer_proyecto_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "primer_proyecto_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "primer_proyecto_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
