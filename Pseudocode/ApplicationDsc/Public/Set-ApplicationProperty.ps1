<#
    .Description
        Sets the state of the ApplicationProperty
...
#>
function Set-ApplicationProperty {
    [CmdletBinding()]
    param(
        [DscProperty(Key)]
        [ValidateScript({
            $_ -gt (New-TimeSpan -Hours 24) -and $_ -lt (New-TimeSpan -Hours 48)
        })]
        [System.TimeSpan]
        $Prop1,

        [DscProperty(Key)]
        [System.String]
        $Prop2,

        [DscProperty(Mandatory)]
        [ValidateRange(0,65535)]
        [System.Int32]
        $Prop3,

        [DscProperty()]
        [System.Boolean]
        $Prop4,

        [DscProperty()]
        [Ensure]
        $Ensure = "Present"
    )

    # Run commands to set the system state
    Set-ApplicationCmdlet -Prop1 $Prop1
    Set-ApplicationCmdlet -Prop2 $Prop2

    #...
}