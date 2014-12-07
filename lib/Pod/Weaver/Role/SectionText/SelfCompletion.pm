package Pod::Weaver::Role::SectionText::SelfCompletion;

our $DATE = '2014-12-07'; # DATE
our $VERSION = '0.01'; # VERSION

use 5.010001;
use Moose::Role;

sub section_text {
    my ($self, $vars) = @_;

    # put here to avoid confusing Pod::Weaver
    my $h2 = '=head2';

    my $command_name = $vars->{command_name} // 'SET_ME';

    my $func_name = $command_name;
    $func_name =~ s/[^A-Za-z0-9]+/_/g;
    $func_name = "_$func_name";

    my $text = <<_;
This script has shell tab completion capability with support for several
shells.

$h2 bash

To activate bash completion for this script, put:

 complete -C $command_name $command_name

in your bash startup (e.g. C<~/.bashrc>). Your next shell session will then
recognize tab completion for the command. Or, you can also directly execute the
line above in your shell to activate immediately.

You can also install L<App::BashCompletionProg> which makes it easy to add
completion for Getopt::Long::Complete-based scripts. After you install the
module and put C<. ~/.bash-complete-prog> (or C<. /etc/bash-complete-prog>), you
can just run C<bash-completion-prog> and the C<complete> command will be added
to your C<~/.bash-completion-prog>. Your next shell session will then recognize
tab completion for the command.

$h2 fish

To activate fish completion for this script, execute:

 begin; set -lx COMP_SHELL fish; set -lx COMP_MODE gen_command; $command_name; end > \$HOME/.config/fish/completions/$command_name.fish

Or if you want to install globally, you can instead write the generated script
to C</etc/fish/completions/$command_name.fish> or
C</usr/share/fish/completions/$command_name.fish>. The exact path might be
different on your system. Please check your C<fish_complete_path> variable.

$h2 tcsh

To activate tcsh completion for this script, put:

 complete $command_name 'p/*/`$command_name`/'

in your tcsh startup (e.g. C<~/.tcshrc>). Your next shell session will then
recognize tab completion for the command. Or, you can also directly execute the
line above in your shell to activate immediately.

$h2 zsh

To activate zsh completion for this script, put:

 $func_name() { read -l; local cl="\$REPLY"; read -ln; local cp="\$REPLY"; reply=(`COMP_SHELL=zsh COMP_LINE="\$cl" COMP_POINT="\$cp" $command_name`) }

 compctl -K $func_name $command_name

in your zsh startup (e.g. C<~/.zshrc>). Your next shell session will then
recognize tab completion for the command. Or, you can also directly execute the
line above in your shell to activate immediately.

_
    return $text;
}

no Moose::Role;
1;
# ABSTRACT: Provide COMPLETION section text

__END__

=pod

=encoding UTF-8

=head1 NAME

Pod::Weaver::Role::SectionText::SelfCompletion - Provide COMPLETION section text

=head1 VERSION

This document describes version 0.01 of Pod::Weaver::Role::SectionText::SelfCompletion (from Perl distribution Pod-Weaver-Role-SectionText-SelfCompletion), released on 2014-12-07.

=head1 DESCRIPTION

This role provides text for "COMPLETION" POD section. The text describes
instructions for activating tab completion for script, for several shells. It is
meant for script that can complete itself (detecting environment variables like
C<COMP_LINE> and C<COMP_POINT> and act accordingly).

This role is currently used by
L<Pod::Weaver::Section::Completion::GetoptLongComplete> and
L<Pod::Weaver::Section::Completion::PerinciCmdLine>.

=head1 METHODS

=head2 $obj->section_text(\%vars) => str

Variables:

=over

=item * command_name => str

=back

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Pod-Weaver-Role-SectionText-SelfCompletion>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Pod-Weaver-Role-SectionCompletionSelf>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Pod-Weaver-Role-SectionText-SelfCompletion>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
