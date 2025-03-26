wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False
wmic pagefile where name="C:\\pagefile.sys" set InitialSize=2048,MaximumSize=4096
