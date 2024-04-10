# The code that will perform the auto-completion
$scriptBlock = {
    # The parameters passed into the script block by the
    #  Register-ArgumentCompleter command
    param(
        $wordToComplete,
        $commandAst, $cursorPosition
    )

    # The list of values that the typed text is compared to
    $allBranches = git reflog | ? { $_ -match ': checkout: moving from (.*) to (.*)'} | % { $Matches[1] }
    $unique = $allBranches | Select-Object -Unique
    $last20 = $unique[0..20]

    foreach ($val in $last20) {
        # What has been typed matches the value from the list
        if ($val -like "$wordToComplete*") {
            # Print the value
            $val
        }
    }
}

# Register our function and auto-completion code with the command
Register-ArgumentCompleter -Native -CommandName @("git", "checkout") -ScriptBlock $scriptBlock