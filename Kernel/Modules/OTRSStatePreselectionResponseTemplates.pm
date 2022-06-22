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

package Kernel::Modules::OTRSStatePreselectionResponseTemplates;

use strict;
use warnings;

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub PreRun {
    my ( $Self, %Param ) = @_;

    # Only for AgentTicketCompose.
    return if !$Self->{Action};
    return if $Self->{Action} ne 'AgentTicketCompose';

    # Only if the mask was called initially.
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');
    return if $ParamObject->GetParam( Param => 'StateID' );

    my $ResponseID = $ParamObject->GetParam( Param => 'ResponseID' );
    return if !$ResponseID;

    my %Response = $Kernel::OM->Get('Kernel::System::OTRSStatePreselectionResponseTemplates')->StandardTemplateGet(
        ID => $ResponseID,
    );
    return if !%Response;
    return if !$Response{PreSelectedTicketStateID};

    # Get possible next states.
    my %NextStates = $Kernel::OM->Get('Kernel::System::Ticket')->TicketStateList(
        Action   => 'AgentTicketCompose',
        TicketID => $Self->{TicketID},
        UserID   => 1,
    );
    return if !$NextStates{ $Response{PreSelectedTicketStateID} };

    # Set preselected state ID via param object.
    $ParamObject->{Query}->param(
        -name  => 'StateID',
        -value => $Response{PreSelectedTicketStateID},
    );
    return;
}

1;
