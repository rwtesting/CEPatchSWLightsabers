#!/usr/bin/perl
use strict;
use warnings;

use lib "../../_lib";
use RWPatcher::Weapons::Melee;

#
# Generate CE patch for $SOURCEFILE:
# - add weapon bulk
# - add armor penetration (tools nodes)
# - add EC attribute to tools node entries
# - add CE weapon tags
# - add melee crit/parry chance as offsets (same as CE patches for core melee weapons)
# ? Do I need to do something with deflection?
#
# Write results to $OUTFILE (overwrite existing).
#
# Warn+Skip if weapon found in $SOURCEFILE that we don't have CE data for.
#
# Armor Penetration
#   - In a17 was per-weapon
#   - In b18 is per tools item
# For b18, we'll set armor pen based on tool capacity and default to a17 value
# only if tool capacity can't be determined/mapped.
#

my $SOURCEFILE = "../../918200645/Defs/ThingDefs_WeaponMelee/PJ_Lightsabers.xml";

# Give all lightsabers the same CE values for now.
# (same as vibroaxe/Vibrosword from SWF patch, modeled after core gladius/longsword)
my $DEFDATA = {
    Bulk             => 1.5,
    armorPenetration => 0.15,
    MeleeCritChance  => 0.5,
    MeleeParryChance => 0.65,
};
my $WEAPONTAGS_1H = [qw(CE_Sidearm CE_OneHandedWeapon)];
my $WEAPONTAGS_2H = [qw(CE_Sidearm)];

# CE Values for each melee weapon, from a17 patch by jaeger972.
my %CEDATA = (
    SWSaber_Lightsaber => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_1H,
    },
    SWSaber_DookuSaber => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_1H,
    },
    SWSaber_KyloSaber => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_1H,
    },
    SWSaber_Doublesaber => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_2H,
    },
    SWSaber_ObiSaber => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_1H,
    },
    SWSaber_ElectrumSaber => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_1H,
    },
    SWSaber_Ahsokasaber => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_1H,
    },
    SWSaber_Inquis => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_1H,
    },
    SWSaber_JGuard => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_1H,
    },
    SWSaber_Quigon => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_1H,
    },
    SWSaber_Darksaber => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_1H,
    },
    SWSaber_Yodasaber => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_1H,
    },
    SWSaber_MaceSaber => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_1H,
    },
    SWSaber_SaberPike => {
        %$DEFDATA,
	weaponTags => $WEAPONTAGS_2H,
    },
);

my $patcher = new RWPatcher::Weapons::Melee(
    sourcefiles => [ $SOURCEFILE ],
    cedata      => \%CEDATA,
) or die("ERR: Failed new RWPatcher::Weapons::Melee: $!\n");

$patcher->generate_patches or die("ERR: generate_patches: $!\n");

exit(0);

__END__

