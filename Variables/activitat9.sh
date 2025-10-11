#!/bin/bash

CRACK="kiliankiliankilian"

echo "The result of ##*ori is" ${CRACK##*kil}
echo "The result of #*ori is" ${CRACK#*kil}
echo "The result of %%ol* is" ${CRACK%%an*}
echo "The result of %ori* is" ${CRACK%kil*}
