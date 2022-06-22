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

package Kernel::Language::de_OTRSStatePreselectionResponseTemplates;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminResponseTicketStatePreSelection
    $Self->{Translation}->{'Manage ticket state pre-selections for response templates'} = 'Ticketstatus-Vorauswahl für Antwortvorlagen verwalten';
    $Self->{Translation}->{'Edit Response'} = '';
    $Self->{Translation}->{'Pre-selected ticket state'} = 'Ticketstatus für Vorauswahl';

    # SysConfig
    $Self->{Translation}->{'Frontend module registration for the admin interface.'} = '';
    $Self->{Translation}->{'Manage ticket state pre-selections for response templates.'} = 'Ticketstatus-Vorauswahl für Antwortvorlagen verwalten.';
    $Self->{Translation}->{'Provides state preselection functionality for responses.'} = 'Stellt die Funktionalität der Ticketstatus-Vorauswahl für Antwortvorlagen zur Verfügung.';
    $Self->{Translation}->{'State pre-selection for Templates'} = '';
    $Self->{Translation}->{'Ticket state pre-selection for response templates'} = 'Ticketstatus-Vorauswahl für Antwortvorlagen';


    push @{ $Self->{JavaScriptStrings} // [] }, (
    );

}

1;
