$ErrorActionPreference='Stop'
$p='D:\workshop\Kumari_Cinema\Kumari_Cinema.csproj'
$t=[System.IO.File]::ReadAllText($p)
if($t -notmatch 'Oracle\.ManagedDataAccess'){
$ins=@"
    <Reference Include="Oracle.ManagedDataAccess, Version=4.122.21.1, Culture=neutral, PublicKeyToken=89b483f429c47342, processorArchitecture=MSIL">
      <HintPath>packages\Oracle.ManagedDataAccess.21.15.0\lib\net462\Oracle.ManagedDataAccess.dll</HintPath>
      <Private>True</Private>
    </Reference>
  </ItemGroup>
"@
$t=$t.Replace('    <Reference Include="Microsoft.CodeDom.Providers.DotNetCompilerPlatform">','    <Reference Include="Oracle.ManagedDataAccess, Version=4.122.21.1, Culture=neutral, PublicKeyToken=89b483f429c47342, processorArchitecture=MSIL">
      <HintPath>packages\Oracle.ManagedDataAccess.21.15.0\lib\net462\Oracle.ManagedDataAccess.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="Microsoft.CodeDom.Providers.DotNetCompilerPlatform">')
Write-Host 'Added Oracle ref'
}
$marker='<Compile Include="ViewSwitcher.ascx.designer.cs">'
$add=@"
    <Compile Include="App_Code\DbHelper.cs" />
    <Compile Include="BasicForms\Users.aspx.cs"><DependentUpon>Users.aspx</DependentUpon><SubType>ASPXCodeBehind</SubType></Compile>
    <Compile Include="BasicForms\Movies.aspx.cs"><DependentUpon>Movies.aspx</DependentUpon><SubType>ASPXCodeBehind</SubType></Compile>
    <Compile Include="BasicForms\TheatreCityHall.aspx.cs"><DependentUpon>TheatreCityHall.aspx</DependentUpon><SubType>ASPXCodeBehind</SubType></Compile>
    <Compile Include="BasicForms\Showtimes.aspx.cs"><DependentUpon>Showtimes.aspx</DependentUpon><SubType>ASPXCodeBehind</SubType></Compile>
    <Compile Include="BasicForms\Tickets.aspx.cs"><DependentUpon>Tickets.aspx</DependentUpon><SubType>ASPXCodeBehind</SubType></Compile>
    <Compile Include="ComplexForms\UserTicket.aspx.cs"><DependentUpon>UserTicket.aspx</DependentUpon><SubType>ASPXCodeBehind</SubType></Compile>
    <Compile Include="ComplexForms\TheatreCityHallMovie.aspx.cs"><DependentUpon>TheatreCityHallMovie.aspx</DependentUpon><SubType>ASPXCodeBehind</SubType></Compile>
    <Compile Include="ComplexForms\MovieOccupancy.aspx.cs"><DependentUpon>MovieOccupancy.aspx</DependentUpon><SubType>ASPXCodeBehind</SubType></Compile>
"@
if($t -notmatch 'DbHelper\.cs'){$t=$t.Replace($marker,"$add`n    $marker");Write-Host 'Added compiles'}
$marker2='<None Include="packages.config" />'
$add2=@"
    <Content Include="BasicForms\Users.aspx" />
    <Content Include="BasicForms\Movies.aspx" />
    <Content Include="BasicForms\TheatreCityHall.aspx" />
    <Content Include="BasicForms\Showtimes.aspx" />
    <Content Include="BasicForms\Tickets.aspx" />
    <Content Include="ComplexForms\UserTicket.aspx" />
    <Content Include="ComplexForms\TheatreCityHallMovie.aspx" />
    <Content Include="ComplexForms\MovieOccupancy.aspx" />
"@
if($t -notmatch 'BasicForms\\Users\.aspx'){$t=$t.Replace($marker2,"$add2`n    $marker2");Write-Host 'Added content'}
[System.IO.File]::WriteAllText($p,$t)
Write-Host 'CSPROJ_UPDATED_OK'
