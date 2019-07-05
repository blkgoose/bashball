#!/usr/bin/env bats

function bb {
    bash <(cd .. && make compile) $@
}

function teardown {
    find * | grep -v "\.bats$" | xargs -r rm -f
}

@test "standard build procedure" {
    echo "echo 'done'" > main.sh

    run bash <(bb main.sh)
    [ $status -eq 0 ]
    [ "${lines[0]}" = 'done' ]
}

@test "decompression" {
    echo "echo 'done'" > main.sh

    bb main.sh > test.bb
    bb -d test.bb > test.tar
    run tar -tzf test.tar
    [ $status -eq 0 ]
    [ "${lines[0]}" = 'main.sh' ]
}
