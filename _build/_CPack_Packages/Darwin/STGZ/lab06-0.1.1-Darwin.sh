#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the lab06-0.1.1-Darwin subdirectory
  --exclude-subdir  exclude the lab06-0.1.1-Darwin subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "lab06 Installer Version: 0.1.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
LICENSE
=======

This is an installer created using CPack (https://cmake.org). No license provided.


____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the lab06 will be installed in:"
    echo "  \"${toplevel}/lab06-0.1.1-Darwin\""
    echo "Do you want to include the subdirectory lab06-0.1.1-Darwin?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/lab06-0.1.1-Darwin"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +155 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the lab06-0.1.1-Darwin"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� +�+h �}|T���ܽ�y@��D�c6�B�B����Q��l��f7�n ����Ub�P�ж���Ϫ%��b�Կm��A�?ж�Gն��?�������$����=���ܙ3g�̜93�&�r���L��ً��r\���\���9��9��������[̌�[0����Q�l7T5������c �oBU0�.�G���/JC�N��<���r`�M��1��H�������O>�,�1�:� ����i��|:��$iՒe�5��<���|NȧҺ�2L}���(E`�~G����_ufu� �)��Y�J���P���8��[%b%?��_k�K�F���/�mUj~�8�n�OE�d���Nwm�V/���
�$5oIjpov��%�����.�w\�Cɇ�W�S��r�T���
�͢WU,R�2�r�Z�bX#�3
�|DE�qRTr�y����2kIi��M*��x��K<X�|6A�D*��#���LV�&�ۇ��&c홌�Az��S����,�����&`��g�|�E.gբ�-{&�Ѿ�?�.���o~'�!����͹T��)����u��O�O��@�&��ςa6�!χ']��u@��/˹�rV�����lY��|���Qw�R�"�\�g�]|h�F�"��p�����4�H#�4��,��Bg�V�`�1��e� �^p���pisc�O��^#���d���%a���l7x�}[���vQz�+��v�¡�ֆeR��|����8�����t������='�|�v��+����2�����m]z��<��a��bz�\��_�:����P�U�z��O��(7�9%�C��ߠm������T4�#ryN�	(���i;��������K³�r�J�o4�5v��
يY'ʀ�B:D^�;����Y��_�@_rb[Tf��0��s��۱QPF�_+��[�c��(k��y�8��8y~%u����
|iM�9�s��Gsh����sHn7���v��<���<�}�<FJ=�W�A7Ї��z���GYg=���o �e�q�2K[G+�4��#4Oh�sybK��[��0!f�4x�ULu�-m1S��BL��Vv�I�*1�ܾ��wt�d(���i��LKo7�UY.!�-9orh�}(�"���Y��]�� z�L��1�һV�G���o����[���j��a��s|6�$���صK9�¨��>�u=�CZ�o=/���}[Kan���
��xx���?M�>�	��b�߇>��˩:�{�N5�U�*`cJ����T���)��Rݠ�B�!�-ԧA��1n��S�=�w�a��zݞ������q�[{:0?ZA��qX���a���m�X���>����1���6���U\?��{ԟ����^��~x~
��C�sfx��x?��d�����bg�x���|���3���
���:�k���Sa'�AǧI�v!��L���F�bdl;n�90�:��}�k�<XKm3a^*�,�TF"׃4��y(��W�������k�m�����w��z�c1��H6��mfKt�� >�-�u� ��?�>���q�23h]c�4�,�M�w�����5��d8�-�m���׷���}"kF=�C](�5>�>�޷{��Aȁz�U��*\ݫXaОU{����Pn�z߇r]	ȋ���	���y�9���6'D�+X�Ŭ����=�J��_}����lZ�i�,ئ��!lZ=�@y�ZK����
�7vE?2C����T�"a�M�r�0:V�ӫˌЯQ��v��X+��X�>E_/����߿�|��Ŕ�}�5�s�-�6�9�BƦ�8=�=��|�f�'�v։�6I�m�\�������9��K��-P>��m��Zr���sXf�~П��8���A���6����
����"�)�?3�,�}CΛ��P�G�텲�H،!ꐜ���4�*1z���ẐqW��8�Z�x�k���d]-�r�f�؆~�6�B9�1�٤n1�K���!�H�NC|p;����&ah�(͜G{ ��Y{/m��|JX{ж�������Y��o`Ho�y̧g���Z?Zo�}2N�F�f��*�<��g4�'��_й��MȺ��,��M��W�;��������J��;�zs�*�%�o�c�������-��}����D=���6���Xۀ|�f�#���:c�2���u^*�6����Λ?��>���5]�`\���N��R�m�׃�� �mB�4}����y �A�����j�g�ڏ݁�f�O��	~a[�,gL�,�o���Ł�ԧ��հf�a��>�3��?�uX�:cs��)a�����#�k��w�#�X�#�[��S��w���!X�^7��7u���YN���e�����:F��%���A��T��u�~Ts7�R�gfU}#�w/�w����5�
�y��p�u��L������+H?��p�^�k#N��߿����z\{Pƃ>���l��uz��Y�ϡ_�ɞvm�Y�Qh�����10�n-�M&[t����(��d:���e������0Ɉ���엔Fޯ(���hcP��`�u�u���pkB5�p��m��qY����6�{zKam�~� ��:H�X�0��E�8	ψ+�,����?M�b���G��:��V�����5?ς�7�upn��87q�83��=�+��e�����T��ciG����`�v1vA�:V��<���죃���������0�Z��r�lHg��W����'��W�s�p�3�^P'X�E�Wu٧Q���G�&?��&����l��|g��#��I�x拱�^�k�� ,�{��{P�`�>��'�`�>R{���M��L0\����l�;s�����/ຍ
g�:�u�gz�:w��x����������2	���R'l�h��!n��� ^o酅����B�.�3�b��a�:�Q�ㆯ@��5���rM��fv�����s���*��NZ7�����;�y&��_���x��
?����ZA�K���Y�\�'i�L�s�@���P�����8�L'v�*u��ڞ!�k������jO����-�+��-���Av��C��ާ��?p?�:4�<E�υ���G:=x�r���
�+��L+ط��&��yq���{���E�n�R�$����߭���O�9�膹�K�i�"=N��U�')�7)�3�4Ez�"=W�^�H_�H�*���HߦHI�^�H_�H_�HߣH߫H_�H�Q��+�U�t�"�U�7�t��2ˈ_����18�&�jV���an��N�l�u��r�6D};��D3c/��.Q8.&)>��>��t�Wu�1������>3~� ����2S6���������?
�!�;�`�������3�EA8So	������c�7�YF���Y��H�bY���K��'����{W��1�'���%��J9��t�-�[=�;l5�ߧ"=�z?�e�[S��	�!���⋘N�[w@��%3;��h!c�aadB|�f�͗@�B�a<���Թ�lL�VA�P�33��	��A�bm��n'8���L8q��	ka�����a�m1 Oނ�D,>��eb�qP7��8Y ]S<��3��Y9�	�C�&'0�m�m���Ld�j�|Z&2�)��@l��7pL�A��L� q�&솃p�T&|<R2�@7��X��t�Bz�th6�U3���e!��3��g&�S�Fi��Fi��Fi��Fi��F���&�b�"�z��(Gq4��c(��8��x��S<���)�H�$�'S�D���R<��d��S<���P�Jq��)�E�l��p�4�חFi��Fi��Fi��Fi��Fi��Fi��Fi��Fi��Fi��Fi��Fi��Fi��Fi��Fi��Fi��F�=�[�]2X��?�+���e\�+��v�0vBh��w&�	� $��=_�pB��	]VG1�&� �a�8&4A8 �m��PB5��Cx���L�!��t��r�@8���e}�@x1� ��k�*�y��S���m.Ga��!������ڊl)�YmU3;=>���s�:�PźI~Z���qyj�v���z�Ź�Ue���\��]�����T�ͮ�UK6�׶Er;6K�X�pP��\��-�_[y��6���ڜ~_��j��B�{��x1�Z IN�ӏb֍�:��Y����j��Ƅ�����zg�.[]x.�����n�!-�ȓ.���i����*2���-��10Y��������s�!]]��K6w�d��}�j�W�:�����+��]��z=>����:���wȅ+K#�[��u�� ����&�������;=���*G��-�3��@�eUf�xaj�}@P��(�;�>���r��H��!����N�S��5�9�T稫�l�	8�	��-A���n��_jv;r
�s�sKWԙ�a]Є,���.o���r���Ǎ��9�0NvO�y���;v]�RE��i�3�B���;�6�u�F����k� O�Q]��\GZG��M6���/��Ȉ����lTڶ���ZZ��2�W��	�z��߽���W����c2�#R��]���H&k��k<�:��z9�P4{B'�F ���X#��7�
�谁a/�"��%��4ĺ�/�\�iuQFQRVVRF�w��ʔ�zSr�1+1��(3kER�)33#)#)�2#��$�Y&SReffR��I���O���(�Ș�Qd)��Hګ+jRRo�2���fKrf���T�Riڐ�6�lH
�"����	M�4��%-�7��v�;�9>G�Y�����4p���I���Kb8�G�z��~��ۄ8�Z,�/��։O���8a�I?E�B87��J�E���E�'�[���~
ǖ�ğ�W�6���	76L��)«	�!|�p�T��.!lL�x�/~��A�=��D���q\E�������|"���O	?Ex�$�O����0:���O��o'�H��]��A���)����9�Lx#��	7~��]�L!�	�p7���ตp6ᨩ�N���a�/~5P~�'\M8q&�pI
Ǔ�i��&���K���r�:��w	�g����7�F8y&�#�J��pT
���o��	�����	�LxQ*�g��#�d$�B8��3���,��	o#|]:���4	[O5��!�@�U¿%�z��'�:­�C�(ᅳI��p5��	�#|��g��$�r	���_��	�	{	�#���q�G��r|��턓/��%\L8y�~�&���@�#·v�%�n#|�p�<�_&�E�7vn'���?<A���L��'�Ex�	~��J��"|���0���_'�I�ۄ̈́^Nw���ī3ڟ���{`<�O���I�c�]2��Oև����%A�� ��gN���X�^��N�M�U�Ux��תp�
�C�/��-*��
�B��V�U�Ҩ`\��kT�^��U��T�*��
�A�����*<e\0����q��D��B��f���/b��6�!��_�p'�� l��a������p?�o2�u� |�{!<�!U[�P{�����	��.���6�-��&���)d5�Jᒏ����❣�#�H�ԡ�)I>A��Zh���v�9����Yp�9��u�9�w��9J3,�����Źñ]����{>��Z��9��a�����/�l��V�K����fI�v��\~�@H~[��b�d����VVf�UK|:2����{�}���I�-�nԂ� ���Zk$�F(QpS+�9�D��7�&�r���=���~����[z�s0Kܯp4�{i*�
�֭*�T�˧|>Bo�˩�s��NK��]�(�*K�9R���k�����-��`#�����p��	5���Ue&�N�\��2U���e��e�k�by>{�}S�3�70����W(�R�U5��:����p�V���`��B����l�7�4�a�}kx�2��e��ERe!��#4m�q�\�<�PPcs���bX9��`���G+\/�.��6d���!�"6;�������?0Kyw"���i��K\c�}���~A��1�Gn�~H��#٪�q	���*%����P�RR��醙0���&>��q�F�@&��ˌ�#
>�
y����H�P~����Gj���:��"������>�h&X��[s��<���~�{V�y�Y�n��jh9�D�lC�5W����p]gs58���4��#/z_5�X`��J����b�P�p^Xg����yO�����Z�Ǜ���.��;�tq4��T��`F����Y�hk��Q������h]#�"ن��ơ"g,������~���/Pv>,�1��FϮ~Eċ�z��o�)4tC�O*�!���p\)��$6��=�������	&�&4����n1��pF7]�os�=h��vS�Q�V��/�"+T౰�hA�.���x���F�6X�j�f���R���:M��Li@��W��Q���:����6*�-���>�F��a��CoFpֈp�9��4z�v�#�E޸ˆ}m]���c���fK����|4��j�ZOA7���d�/�a�ErXƀ}�:̡:G�B9�����k� �0W����h��_繜5���l�F߀������m�c;jf�P~��/��Epÿ�c�hL�O��|�W�+�����u/����~�Y��lE�؁�\�*{}���&�9T��V�A����r�
y�nQ����怀�^��W�ꤏp���
wA�O�lrx�W�0�5`~"���9�=��.*�t�5���{SI}� ��M�z��s�<�B��P�.Ay�,�Ӌ�*e�:���Vn?�np}ER���$�+U�)�V��ꗗU�(iƭ��j����0S�x��ư&͘\��'�X����>� �T�rd� '7$� $'/?4�p�C���f���c�����	=l���$�ïo�e:=~��|VCXM��;���c�lD��'lt��������ެ���׮N�/�dϢ��������:f���o��کy};^�(�7o��g&<�H��U��'w�ܜz���:^���9ں���{�����(��s�_����^���'��[?����5��7:;oЭ\տ��m7���s;�ߝ���?���s�m����v�u�O��;��������L�?��m�ox��척�=�����xk�˓b�tϸ��}�/�i��7�����gҞ}��e�p�������O��t�����;���K�{;^��7Zjn9������k㶝���.8Yq|嗌�ſV�s���ucZ��K�/l����J�^�S��K�O?��i�ES�ӽ��q���xmdgg/��7�q��sM<��1�,��6��g��.���6��s��M̘}�D����Q�l7T5������ܙl�@�߄~�ɇ�я`Ȇx�0�w4͒�O����QX�d�u��|e(!4+���	�TZWW��oQU �L��	�`15��ϓ�1bS�^��_Q��o��E�w�RίI�J~�?P��nW�j~�E��Zaɧ"�F�sA��ٜߵ
�$5o���.w�k<a��K�z�A<�|8�{e>%K*�H�+����,�qU�",�(ׯ�(�5"��� QQ~ß������זYKJ}l"��1Rw1�<�MP"��m�f,���;An׍��P�a�0Dg�y���8�f
i�?G��"S�n����O���<[���.�sŢ�-�jz>��x���Ϳ�C���WK�'�=���>%��O�Ӳ����0�� �lMȧC�}!̦6���+�Ȃ眅/˹�rV�����lY��|�8�]����4��i�������|��穄�� ����i��Fi���x�/;������珥�?�u�w٢�i칖��G[�Xg��z[�!]�hH��G���%��
�}R��~�hK�J���Y�k�`�-�Ҏ�C�=�h�v���b��Q:�V�v�/��rl��V�й��q�(t�Hg�*]�~�w2�/���һ�? P]H�@�(����v�Ú���b�Y�Q�|�S�:	�o#^]�NC��\
ċe�i=ݢp��Xꑙ*��(�j剃�a�`���v?�&[w��n<�g����{f�l3Yo�LK��A���2��O��P��5g��ye��A�/�{2�njy��aܛ�E��!e��'H.��d��C����������I�����8�{�I̇Sq�^�5�r,�	�se
��ۺ� ԕeP�9�s��|��'���Py)��m}�,k~��::X�p<�����.@���}00�{�oO�i���؏�����Բ����療Gw��J��t%�Ef��O�0�4lw}�<����"�����`�<u1�d��u�by� �3���4�؇��փ �,������oǾ
 7k��zG�aw#~�����.�~����c�(k=�����c�a���pst�A`7vE?2#��j\�1]~�hg�@��9[�	�q�q&�n�ƍd��0�JV}�>Wee��u��C]�Lg��ŘC,�rP�x����~qP����e�s<���-㘢]=����q8Q���/��9M�_����:�k �yj=���T������;�����i~�X!/��Ccf��ʇ���r����8U��v���
}��=�G���|��6q<&*lB<�w`\�j�������1���dK��q�m��n4���ry�2�[�Ϟ"��W���:�}��� س����Q�颶1݈|��6y�\fi����v����`:�'F��οu}bv�`_�*��Ŗ���M�!&�p+�Y��YX� �:�������0-כ�6x+�%�%�Mm�e_����"Kۻ��w�>s2��<K�2���]���*����-z�W5���/����ty�K�}0���A�:�Ч����j~��<�Ҏ�������x���?M�?s�r�]��(���P����0�	���� X
a��4������?�=��1����q\Z{:0���(�l]`��G}�lO���A[����Z�ه4c>�uC����qi"��{ԟ�������#���)�ڐ�3�����y\�$�5�+�;[�˜|̸ࣷ�p=H6#`_���oOA��5�{�i��]m3���y=��0^�3�<ż�C������0/�d�u*����k�����3�gl�u����A�CEQ��Nτ�ˊ9�b,m��->G;ʖ�;p�	����o*��>�M�q�2��<�g�GJa���߲���=2#������`���"� r?Ƈߣ�{j`?�}���Ϟ����W���~���l��P�+y���`�2Av��8o3�����
�|j1k�k_�y#�~�#_�=6�������T>�ġ|�0z(~��-�r#��"��"ףҞ�*e-|�1$�΅�ёd��ܔȾ
��6�6< n��~C��]����C����8�v~^/���;W�@����h���j�gW���e�����1ԏ�2���遳�3YN������_a�V��hR�1�gf���NӇ������
嵝�^(����z��i0Z��<�&1
���<�鹱���F6�yn��\��K?�{����G[�?��_�����1�.qv�RÜ�G�����f��K=�rl�Q�ј�s�w���q`>�դk~R�yG�Wm��A�4���?�y~��V̧3�?��MG�eV����������3�J; �	��4X���2�Ncɳ�Z����{*����&�gyN���~�l��@=����-�[D���G��>+-�e;K~�i�n�=�_��$����h�]<1�K�|y�L����W��W��8�!�� �t��c>=�T����zs7�q�;��!�N��<���4fA���5b@��=y��簪p�p��7(w�����P��`M�^���K�/E=���O�<G��|�{���g���C|zkЃ/����u��@g���1���Y������U�[_�k��4��	�^F��`�a= |����~�z�7= ��ހ��?k�g�ڏ݁�f�v3<_�-S�3&V�ӷ����>���j�°z|V��c�u��c���X�C��.Ы�-����%D��]FxO���O��j��!�g�s�i�{��$�r*����O:7^��b�_�Ny����?	�c��;�𻚻��B>3#���d��ą�s�x�ݠ������p�u��L������+H?��p�^�� N��߿��!��z\gPƃ>���Cl���z��A�Я�d;�����P���*�sj�n2ٝ���WG��`�8��l�>�	��&��$#�Hó_Ry��X��	���2w�yݥ�z���w{0�����3U�e�N�>��ܗ�-�uc�Ճx�� =b�,v��$<CJ��[�v�x�>j4a�c�>�8?��s[5g�-�Rl~��r���U��!�/gj'��=��{�u�����p,��5���٦��]��������?"��]��������0�ZĶ�� �u�/�}�i���J��`�|K`�z��	�{!�k��UD�E�Ӕ�����OGr�>�9�3���M@=��g<#�Xz���o�@�=��i�1��<�I|1��.����{s�����g�?4|��\�Q�l�BgC�񎃺���*uxg$�c�B+�A��'�o-��{щ�w)���"��Ǘ&Yz�
d�D~�)��	��P�O�|G5L�T�踡�%�9d��k:�5��7�?ܜ��_�V��wҺ1��g}�ߡ31�.zp<�ǿ���A������K��U�Q�?��(����$�'�;|�2�Y�	�]�J,��g��"��>:����X����@�e{%�����A�!Ȏ�5�x����g�}�H�w�C#|O{*�{��{�Sуw�(ׯH����|/%�}mm�o������i��_�=�'����nO�{��*�a�%�sW���:Ez�"�HOP�g(��R�g+�s���e�t�"]�H_�HI�^�H?�HG�.W��S��(���*E�{��!EګHoR�oR��]��M��W�����Z'�2?c�����BR�.�1!�.�e� 9'���tQg��tQM�v�:���I�^w��[�
�Z������z�7�nn�KY����Q�O	�r��_�Ǐ�M�լ���sS�uBf��K't�3�KԷ��P43hG�%
��$����&�}��>��U{Lw�xC[���U�o+��̔��H���6��%0W�@e�eXu�Q8�	��)��%Ǘ�C��/
zKP{�`�z˰0֘c���s��'L/7V;}v���o,2f�K#Q,�e��c\)��A6aPe�v=K���r�������?�3�Ci��?R��#,�����l���ีB��~�#S� �τF�� Dć�ˀ�v��]��+!��X5���V������[�xv���e����tL��}=���=�	��A��0�	~p ^��b}4�mG�b�[T��0�L���LX�S��n�gB�x�<ӿq�&�L`��s�n�ן���	r�u%�Lؖ���a�$Oy`���݉L�8�	���.t�10�䮩L@�$Oc���Mc��iL�8qԟs`&��Na8x�L�=_�Je�7�:�Nc�tؘe!�62�.#3�Fi��Fi��Fi���ZJ�oOl�Q,R��8��qGSl�8��X��(��x<�(N�8��O�x2�IO�x*��(N�x:�3(�Iq
ũ�Q�N���YϦx�_B�\��Q�I�|�p�61�4�H#�4�H#�4�H#�4�H#�4�H#�4�H#�4�H#�4�H#�4�H#�4�H#�4�H#�4�H#�4�H#�4�H#�4�H#�4:O22����AXȂ���^�NV�-���;�t���B;��!dL��^oB��+2� �"=^��!�	/C�f~�}4L6@xB��	fk ����1L��F�!�(��ބ�	��X֗�-/Ʊ>W<���{�����\[V�ϓ����ns9
|��fw����VdK��j������IU6�����*�M��
N��S�K��+,α�*��}��II� �\��]��� 7��V-ټ^����,�b��Pp�>��*?b���
ȳo�y%�����J�V+��\��ǋ�Ir��~�n̘��G��V_�pW+�:&�Ơ�N���>��d�!��L���a�����Y�k���Y���p��[`V�W�IZ]%p���*���i�+3���-��0��֥���2��s�!]]��K6w�d��}�j�W�:�����+��]��z��Y��C�b��V�/�;��;G��Ge�j�2�/;��u������&��:$G��Q�wz܁'U�Z�[�g���,�K�Q�u��)�Amc�T���<n����"mʆܯ�7;�O���P�`R���γ	�gp�S4'[�N9kݒӿ��v�f�d疮�3�ú��T0P3�1�]�b����%���os�aL��-���v캢��\i�
g6ԅTy�w�m��l���y�#,׺��DP����:�p�pUl��$�Kq�݊���_	���
�{yc��Qi��&��򴖗a��-�W8֓E��2Q�j�og;&��0"E�LwQf�3�H&����|�ǵ�QSSS^S!��������PΒzgO��ߚ�[Þ�`B4:���7:l`��ۢ�:��c���@a�� �]_bJ4,I��Ĥ��L�ꢌ�������)����jcVrQQf֊���̤ʌds�`L6d�Lr�a]r�.+k�.kyQ�11��R����WW�*��4�.de$՛͖��$C��$�Ҵ!%
l(���+�f,Mhb��=Ax�h�M��	�"|#�	#�-��y1%��p�OL�<��̉��6���8�I��-�?%�"��� �&a6����sl"�Lx'�K&p�A���? |�p�dj/��"�o�HX���n�Wn%�H��~q�?�"�a"������>>Bx�$�_N���l:ǟN&�r��&|'�}�;w��.�8N�A�	�&�{�M��	&�r
�=������	�N��.�~����H8g�7��z�E���$|��N³�I�T��	g>L����W�6��F�_"|�p-�.�����	/O�r���Bx/�>����1���Sfq�4��g�p\=�c7�]��#|�pu*�Is8�K�x�7�!���ө����w�#~�p5��F��&|��{��	��E�^B�!�4����d����	�1sh<o$�����!�A�ͤ�K�B���.��J���9�o6���?���_~��;���8aa���!����;�E8e!�/�Ɨp�'�~�����3�,���	W�'��E�a�՗r|a� � ��ۏ���^�q9n%�J��E�? ��0�~y=N"\K8���f�;W~�p5�'�	#|;a�<�7O&|�ֻ��˴��Jư>h<���z{��N�ge�K#�(��@֗N��O)���X�*�A�oR��*|X���V�h1W��#*��
����~I��J(�U*�U�w��>~J�_Raq\0NW�^��kUث»T�{*�C>�����gTX���T8C�/��_�*|;�; |�-��^�a� 4C��7�a?�[�E��B�6�!<a��!��(�� |u��Z!���0m���a�e��=�F��;Z � �A�C@�[�zD�$#Q�O5��8׌�8���M�늑^W�I%�r#�݆k���m�v>���Л��#�6���@�|a^�RX��[]�T�-U�HVXr�ʊBi�K�8G���_���esׂR\�����is֕�cЁ�0�XH�e_u�c�b�X$�bP��������R���-㥌��|	�a�[ʯqz}
σf٨|�4n�Ǐ���{���6�\w��Jm
va�D������ 矛2�����Z[Q�-c��"���^_x�/lT9Sy
Ja�p����?<��2dA��b[��- k�%X5��_�;%���Z������J؂�2�Z*�۴B1�Sr/���Q���D�M�p�@9��D���A3��N���MNp��5���0�p�����z/yFJgȊ�r8\�p�ʱ����%8=J������\��������/a�6;�=�/���p��	5��%p�L�첦j��Ѱ�ϡþ�j�a�Go�b8y�B��=�R�U5��'PAWA����NV�V��M�f�\�p��C���5.[�/�*����Eh�T�t�"�y�����t9�#�Űr��D�CGF��������Ac�?0������tpx�؞���#�*NcЏ����$82۪�Ѫ��U���z���<��{�n�rcꝠ�.J�J�j�L�<�q�ݚ�=��Q���Z���,�.�|o5��f��!��HT��v���l���`�J�[�@��f/0��~m�o�#�V�`ἰ�D80�wC��P�Q�=Ɓ+5�=C%��>-h�
�����l���ed�VqtG�a,�蘏�4���Qن��ơ"Giu�멳�7�|7z��flw�ћ���Wc~�X^��|�8�b߱��R��uV�9�	��!+��+����:�N�/��*�XXA4"yc{{��<H6�Qx87;o�ᅑ�|�j�ń���Kܮ~Ŧ�u��|�� ��N�������y_N���q���Fp;�zdh�a���|G���ʓMo�2�,	��Xl����&)_������SЍ��)=�ѿ�F�t[<�sp�a�9��y�b�'�r�ы�z�V�����Y��;��Vo�����ެ�V?��fV0�cW���߁�"���"<�Z�1��.�?i��NV]*��u/����~�Y��lEz����U��zI]Mns���Y-�MA�49�-r�nQ��4r��}o1X^�M�>�1V�+��>ɳ�ᕿɀQ���e3U�����72��K�Q�o�6���H؄��y�0Ƀ)T�e�Q�'�2;�Q�/V���Ol���C�w�'Fx�-)�ՠOi��W�P���2��lƭ��j����0S�x�ư&͘\�F-�๬�����T�rd��䏠LnHNAHN^(�����D�9�Yy���� }�v|;c:�1��7�I��_��3����o�%���x�^8nԱx6"2��� E�eW�X���1�ݵY3��k
�)$������{������_Kv�4^��뾽wo����N��~��O��wL^�hb�=_��!�ֺ���ym��7�̋}���*�������S'�����?��.<��*������_<����+~��K�ٿ�k߿p�;��SV�~���QWYW�$�m�N���sy�=?���=�8]Ӯ������Q�۞�v�o>�c��Y�����{��Y�^z�Z��?����s�H�>[�����&U�������k�׏�y��5���<��۱�/���M|��?~��wY����-�i_�R�ӝ]�����w����5�<3���<�S�����)��޹���W���a�??���'�ܱ���,�O�z�oO��c�|c]n򙢚ǯ�[�S���{:�ndê�F����H[�� � 