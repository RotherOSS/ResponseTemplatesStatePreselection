# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2019-2022 Rother OSS GmbH, https://otobo.de/
# --
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
# --

package var::packagesetup::ResponseTemplatesStatePreselection;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::SysConfig',
    'Kernel::System::SysConfig::Migration',
);

use Kernel::System::VariableCheck qw(:all);

=head1 NAME

var::packagesetup::ResponseTemplatesStatePreselection - code to execute during package installation

=head1 DESCRIPTION

All functions

=head1 PUBLIC INTERFACE

=head2 new()

create an object

    use Kernel::System::ObjectManager;
    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $CodeObject = $Kernel::OM->Get('var::packagesetup::ResponseTemplatesStatePreselection');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # Allocate new hash for object.
    my $Self = {};
    bless( $Self, $Type );

    # Force a reload of ZZZAuto.pm and ZZZAAuto.pm to get the fresh configuration values.
    for my $Module ( sort keys %INC ) {
        if ( $Module =~ m/ZZZAA?uto\.pm$/ ) {
            delete $INC{$Module};
        }
    }

    # Always discard the config object before package code is executed,
    #   to make sure that the config object will be created newly, so that it
    #   will use the recently written new config from the package.
    $Kernel::OM->ObjectsDiscard(
        Objects => ['Kernel::Config'],
    );

    # The stats object needs a UserID parameter for the constructor.
    # we need to discard any existing stats object before.
    $Kernel::OM->ObjectsDiscard(
        Objects => ['Kernel::System::Stats'],
    );

    # Define file prefix.
    $Self->{FilePrefix} = 'ResponseTemplatesStatePreselection';

    return $Self;
}

=head2 CodeInstall()

run the code install part

    my $Result = $CodeObject->CodeInstall();

=cut

sub CodeInstall {
    my ( $Self, %Param ) = @_;

    return 1;
}

=head2 CodeReinstall()

run the code reinstall part

    my $Result = $CodeObject->CodeReinstall();

=cut

sub CodeReinstall {
    my ( $Self, %Param ) = @_;

    return 1;
}

=head2 CodeUpgrade()

run the code upgrade part

    my $Result = $CodeObject->CodeUpgrade();

=cut

sub CodeUpgrade {
    my ( $Self, %Param ) = @_;

    return 1;
}

=head2 CodeUpgradeMergeFromLowerThan_5_0_1()

This function is only executed if the installed module version is smaller than 5.0.1.

my $Result = $CodeObject->CodeUpgradeMergeFromLowerThan_5_0_1();

=cut

sub CodeUpgradeMergeFromLowerThan_5_0_1 {    ## no critic
    my ( $Self, %Param ) = @_;

    # change configurations to match the new module location.
    $Self->_MigrateConfigs();

    return 1;
}

=head2 CodeUpgradeMerge()

run the code upgrade merge part

my $Result = $CodeObject->CodeUpgradeMerge();

=cut

sub CodeUpgradeMerge {
    my ( $Self, %Param ) = @_;

    # change configurations to match the new module location.
    $Self->_MigrateRenamedConfigs();

    return 1;
}

=head2 CodeUninstall()

run the code uninstall part

    my $Result = $CodeObject->CodeUninstall();

=cut

sub CodeUninstall {
    my ( $Self, %Param ) = @_;

    return 1;
}

sub _MigrateConfigs {
    my ( $Self, %Param ) = @_;

    my $SysConfigObject = $Kernel::OM->Get('Kernel::System::SysConfig');
    my $ConfigObject    = $Kernel::OM->Get('Kernel::Config');

    my $Setting = $ConfigObject->Get('Frontend::NavigationModule');

    my @DeploySettings;

    BACKEND:
    for my $Backend ( sort keys %{$Setting} ) {

        next BACKEND if $Backend ne 'AdminResponseTicketStatePreSelection';

        my $Module = $Setting->{$Backend}->{Module};

        next BACKEND if !$Module;
        next BACKEND if $Module !~ m{Kernel::Output::HTML::NavBar(\w+)};

        $Setting->{$Backend}->{Module} = "Kernel::Output::HTML::NavBar::ModuleAdmin";

        push @DeploySettings, {
            Name           => 'Frontend::NavigationModule###' . $Backend,
            EffectiveValue => $Setting->{$Backend},
            IsValid        => 1,
        };
    }

    # The deployment should only be executed, if it is really needed.
    return 1 if !@DeploySettings;

    my $Success = $SysConfigObject->SettingsSet(
        UserID   => 1,
        Comments => 'ResponseTemplatesStatePreselection - Migrate navigation settings',
        Settings => \@DeploySettings,
    );

    if ( !$Success ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "System was unable to migrate settings!"
        );
    }

    return 1;
}

sub _MigrateRenamedConfigs {
    my ( $Self, %Param ) = @_;

    # Lookup hash for new config setting names.
    my %LookupNewConfigNames = (
        'PreApplicationModule###OTRSResponseTicketStatePreSelection' =>
            'PreApplicationModule###ResponseTemplatesStatePreselection',
    );

    my $Home = $Kernel::OM->Get('Kernel::Config')->Get('Home');

    # Build file location for OTRS5 config file.
    my $OTRS5ConfigFile = "$Home/Kernel/Config/Backups/ZZZAutoOTRS5.pm";

    # If there is a ZZZAutoOTRS5.pm file in the backup location
    #   (this file has been copied there during the migration from OTRS 5 to OTRS 6).
    if ( -e $OTRS5ConfigFile ) {

        # Run the migration of the effective values (only for the package settings).
        my $Success = $Kernel::OM->Get('Kernel::System::SysConfig::Migration')->MigrateConfigEffectiveValues(
            FileClass                  => 'Kernel::Config::Backups::ZZZAutoOTRS5',
            FilePath                   => $OTRS5ConfigFile,
            PackageSettings            => [ values %LookupNewConfigNames ],
            PackageLookupNewConfigName => \%LookupNewConfigNames,
            NoOutput => 1,    # we do not want to print status output to the screen
        );

        # Deploy only the package settings (even if the migration of
        #   the effective values was not or only party successful).
        $Success = $Kernel::OM->Get('Kernel::System::SysConfig')->ConfigurationDeploy(
            Comments      => "ResponseTemplatesStatePreselection - package migration for renamed config options",
            NoValidation  => 1,
            UserID        => 1,
            Force         => 1,
            DirtySettings => [ values %LookupNewConfigNames ],
        );
    }

    return 1;
}

1;
