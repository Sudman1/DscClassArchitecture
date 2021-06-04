<#
    .Description
        Gets the state of the ApplicationProperty
...
#>
function Get-ApplicationProperty {
    [CmdletBinding()]
    param(
        # These params may not be used, but they are here in case they are needed

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

    # create the hashtable to return
    $rval = @{
        Prop1 = $null
        Prop2 = $null
        Prop3 = $null
        Prop4 = $null
        Ensure = $Ensure
    }

    # Run commands to populate the hashtable
    $rval.Prop1 = New-TimeSpan -Hours 30

    #...

    Write-Output $rval
}