#ifndef kutils_h
#define kutils_h
#include "common.h"
#include <mach/mach.h>
#include "IOKit.h"

#define SETOFFSET(offset, val) (offs.offset = val)
#define GETOFFSET(offset) offs.offset
extern uint64_t cached_task_self_addr;

uint64_t task_self_addr(void);
uint64_t ipc_space_kernel(void);
uint64_t find_kernel_base(void);

mach_port_t fake_host_priv(void);

size_t kread(uint64_t where, void *p, size_t size);
size_t kwrite(uint64_t where, const void *p, size_t size);
uint64_t kalloc(vm_size_t size);
uint64_t kalloc_wired(uint64_t size);
void kfree(mach_vm_address_t address, vm_size_t size);
uint64_t zm_fix_addr(uint64_t addr);
void set_csblob(uint64_t proc);
uint32_t find_pid_of_proc(const char *proc_name);
uint64_t get_proc_struct_for_pid(pid_t proc_pid);
uint64_t get_address_of_port(pid_t pid, mach_port_t port);

#endif /* kutils_h */
