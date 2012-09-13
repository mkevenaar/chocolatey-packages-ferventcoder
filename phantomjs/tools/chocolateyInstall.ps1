try {
  $package = 'PhantomJS'

  $installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" 
  ### For BinRoot, use the following instead ###
  $binRoot = "$env:systemdrive\"
  ### Using an environment variable to to define the bin root until we implement configuration ###
  if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
  $installDir = Join-Path $binRoot $package
  Write-Host "Adding `'$installDir`' to the path and the current shell path"
  Install-ChocolateyPath "$installDir"
  $env:Path = "$($env:Path);$installDir"
  $zipUrl = 'http://phantomjs.googlecode.com/files/phantomjs-1.6.1-win32-static.zip'

  Install-ChocolateyZipPackage $package "$zipUrl" "$installDir"
  
  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}
